import Foundation

public class InputValidator {
    public init() {}

    public func inputValidation(pattern: [String], knitFlat: Bool = false) throws -> [RowInfo] {

        for row in pattern {
            let isEmptyRow = validateNoEmptyRows(row: row)
            switch isEmptyRow {
            case .success:
                continue
            case .failure(let error):
                throw error
            }
        }

        var patternNestedArray =  pattern.map { NestedArrayBuilder().arrayMaker(row: $0) }
        if (knitFlat == true) {
            patternNestedArray = knitFlatArray(array: patternNestedArray)
        }

        for (index, arrayRow) in patternNestedArray.enumerated() {
            let isEveryStitchValid = validateEachStitch(stitchRow: arrayRow, rowIndex: index)
            switch isEveryStitchValid {
            case .success:
                print("1")
                continue
            case .failure(let error):
                print("2")
                throw error
            }
        }

        let patternMetaData = MetaDataBuilder().buildAllMetaData(stitchArray: patternNestedArray )

        let isPatternMathematicallySound = validateEachRowWidth(allRowsMetaData: patternMetaData)
        switch isPatternMathematicallySound {
        case .success:
            return patternMetaData
        case .failure(let error):
            throw error
        }
    }


    private func validateEachStitch(stitchRow: [String], rowIndex: Int) -> Result<[String], InputError> {
        let isRowInvalid = stitchRow.firstIndex(where: { !isStitchValid(stitch: String($0)) })
        if let invalidStitchIndex = isRowInvalid {
            return .failure(InputError.invalidStitch(invalidStitch: stitchRow[invalidStitchIndex], rowLocation: rowIndex))
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
        if numberOfRowsToCheck == 0 {
            return .success(allRowsMetaData)
        }
        for rowNum in 1...numberOfRowsToCheck {
            let prevRow = allRowsMetaData[rowNum-1]
            var currentRow = allRowsMetaData[rowNum]
            if !isCurrentRowStitchCountValid(prevRow: prevRow, currentRow: currentRow) {
                let expectedNextRowWidth = prevRow.width + currentRow.leftIncDec + currentRow.rightIncDec
                return .failure(InputError.invalidRowWidth(
                    invalidRowNumber: currentRow.userRowNumber,
                    expectedStitchCount: expectedNextRowWidth,
                    actualCount: currentRow.width
                ))
            }
        }
        return .success(allRowsMetaData)
    }

    private func isCurrentRowStitchCountValid(prevRow: RowInfo, currentRow: RowInfo) -> Bool {
        let expectedCurrentRowWidth = prevRow.width + currentRow.leftIncDec + currentRow.rightIncDec
        return expectedCurrentRowWidth == currentRow.width
    }

    public func knitFlatArray(array: [[String]]) -> [[String]] {
        let numberofRows = array.count
        var flatArray = array
        for rowNum in 0..<numberofRows {
            if (rowNum % 2 == 1) {
                flatArray[rowNum].reverse()
            }
        }
        return flatArray
    }

}
