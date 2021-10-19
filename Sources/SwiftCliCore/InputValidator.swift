import Foundation

public class InputValidator {
    public init() {}

    public func validateEachStitch(row: String) throws -> Bool {
        let rowStitches = row.split(separator: " ")
        guard rowStitches.count > 0 else {
            throw InputError.emptyRow
        }

        for stitch in rowStitches {
            guard isStitchValid(stitch: String(stitch)) == true else {
                throw InputError.invalidStitch(invalidStitch: String(stitch))
            }

        }
        return true
    }

    public func arrayMaker(cleanedRow: String) throws -> [String] {
        let substringRowStitches = cleanedRow.split(separator: " ")
        let rowStitches = substringRowStitches.map {(String($0))}
        guard rowStitches.count > 0  else {
            throw InputError.emptyRow
        }
        return(rowStitches)
    }


    public func validateEachRowWidth(allRowsMetaData: [RowInfo]) throws -> Bool {
        let numberOfRowsToCheck = (allRowsMetaData.count) - 1
        let allCheckedRowsValid = true
        guard numberOfRowsToCheck >= 1 else {
            return allCheckedRowsValid
        }
        for rowNum in 1...numberOfRowsToCheck {
            let prevRow = allRowsMetaData[rowNum-1]
            let currentRow = allRowsMetaData[rowNum]
            if !isCurrentRowStitchCountValid(prevRow: prevRow, currentRow: currentRow) {
                let expectedNextRowWidth = prevRow.width + currentRow.leftIncDec + currentRow.rightIncDec
                throw InputError.invalidRowWidth(
                    invalidRowNumber: currentRow.rowNumber,
                    expectedStitchCount: expectedNextRowWidth,
                    actualCount: currentRow.width
                )
            }
        }
        return allCheckedRowsValid
    }

    private func isCurrentRowStitchCountValid(prevRow: RowInfo, currentRow: RowInfo) -> Bool {
        let expectedCurrentRowWidth = prevRow.width + currentRow.leftIncDec + currentRow.rightIncDec
        if expectedCurrentRowWidth == currentRow.width {
            return true
        }
        return false
    }
}
