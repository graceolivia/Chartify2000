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

    public func verifyValidRowStitchCount(prevRow: RowInfo, currentRow: RowInfo) -> Bool {
        var isCurrentRowValid = false
        var prevRowWidth = prevRow.width
        var expectedCurrentRowWidth = prevRowWidth + currentRow.leftIncDec + currentRow.rightIncDec
        if (expectedCurrentRowWidth == currentRow.width) {
            isCurrentRowValid = true
        }
        return isCurrentRowValid
    }

    public func validateEachRowWidth(allRowsMetaData: [RowInfo]) throws -> Bool {
        var numberOfRows = (allRowsMetaData.count) - 1
        var allCheckedRowsValid = true
        for r in 1...numberOfRows {
            let prevRow = allRowsMetaData[r-1]
            let currentRow = allRowsMetaData[r]
            if (!verifyValidRowStitchCount(prevRow: prevRow, currentRow: currentRow)){
                var expectedNextRowWidth = prevRow.width + currentRow.leftIncDec + currentRow.rightIncDec
                throw InputError.invalidRowWidth(invalidRowNumber: currentRow.rowNumber, expectedStitchCount: expectedNextRowWidth, actualCount: currentRow.width)
            }
        }
        return allCheckedRowsValid
    }

}
