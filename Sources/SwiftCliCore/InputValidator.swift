import Foundation

public class InputValidator {
    public init() {}

    public func inputValidation(pattern: [String], knitFlat: Bool) throws -> [RowInfo] {

        for row in pattern {
            let isEmptyRow = validateNoEmptyRows(row: row)
            switch isEmptyRow {
            case .success:
                continue
            case .failure(let error):
                throw error
            }
        }

        var patternNestedArray =  pattern.map { arrayMaker(row: $0) }
        if (knitFlat == true) {
            patternNestedArray = knitFlatArray(array: patternNestedArray)
        }

        for arrayRow in patternNestedArray {
            let isEveryStitchValid = validateEachStitch(stitchRow: arrayRow)
            switch isEveryStitchValid {
            case .success:
                continue
            case .failure(let error):
                throw error
            }
        }

        let patternMetaData = MetaDataBuilder().buildAllMetaData(stitchArray: patternNestedArray )

        let isPatternMathmaticallySound = validateEachRowWidth(allRowsMetaData: patternMetaData)
        switch isPatternMathmaticallySound {
        case .success:
            return patternMetaData
        case .failure(let error):
            throw error
        }
    }

    private func arrayMaker(row: String) -> [String] {
        let substringRowStitches = row.split(separator: " ")
        let rowStitches = substringRowStitches.map {(String($0))}
        return(rowStitches)
    }

    private func validateEachStitch(stitchRow: [String]) -> Result<[String], InputError> {
        for stitch in stitchRow {
            guard isStitchValid(stitch: String(stitch)) == true else {
                return .failure(InputError.invalidStitch(invalidStitch: String(stitch)))
            }
        }
        return .success(stitchRow)
    }

    private func validateNoEmptyRows(row: String) -> Result<String, InputError> {

        guard !row.isEmpty else {
            return .failure(InputError.emptyRow)
        }
        return .success(row)
    }

    private func validateEachRowWidth(allRowsMetaData: [RowInfo]) -> Result<[RowInfo], InputError> {
        let numberOfRowsToCheck = (allRowsMetaData.count) - 1
        guard numberOfRowsToCheck >= 1 else {
            return .success(allRowsMetaData)
        }
        for rowNum in 1...numberOfRowsToCheck {
            let prevRow = allRowsMetaData[rowNum-1]
            let currentRow = allRowsMetaData[rowNum]
            if !isCurrentRowStitchCountValid(prevRow: prevRow, currentRow: currentRow) {
                let expectedNextRowWidth = prevRow.width + currentRow.leftIncDec + currentRow.rightIncDec
                return .failure(InputError.invalidRowWidth(
                    invalidRowNumber: currentRow.rowNumber,
                    expectedStitchCount: expectedNextRowWidth,
                    actualCount: currentRow.width
                ))
            }
        }
        return .success(allRowsMetaData)
    }

    private func isCurrentRowStitchCountValid(prevRow: RowInfo, currentRow: RowInfo) -> Bool {
        let expectedCurrentRowWidth = prevRow.width + currentRow.leftIncDec + currentRow.rightIncDec
        if expectedCurrentRowWidth == currentRow.width {
            return true
        }
        return false
    }

    public func knitFlatArray(array: [[String]]) -> [[String]] {
        let rowNum = array.count
        var flatArray = array
        for r in 0..<rowNum {
            if (r % 2 == 1) {
                flatArray[r].reverse()
            }
        }
        return flatArray
    }

}
