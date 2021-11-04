import Foundation

public struct RowInfo: Equatable {
    var row: [String]
    var rowIndex: Int
    lazy var userRowNumber: Int = rowIndex + 1
    var bottomLine: String = ""
    var stitchSymbols: String = ""
    var width: Int = 0
    var patternRowsCount: Int = 0
    var leftIncDec: Int = 0
    var rightIncDec: Int = 0
    // This is about the number of "empty stitches" that should be added on the left to account for future increases
    var leftOffset: Int = 0
    var transRowLeftOffset: Int = 0
    lazy var leftOffsetString: String = String(repeating: "  ", count: leftOffset)
    lazy var transRowLeftOffsetString: String = String(repeating: "  ", count: transRowLeftOffset)
    lazy var offsetBottomLine: String = leftOffsetString + bottomLine
    lazy var offsetStitchSymbols: String = transRowLeftOffsetString + leftOffsetString + stitchSymbols
    lazy var totalRow: String = offsetStitchSymbols + offsetBottomLine
}

public class MetaDataBuilder {
    public init() {}

    public func buildAllMetaData(stitchArray: [[String]]) -> [RowInfo] {
        var allRowsMetaData = [] as [RowInfo]
        let rowsNum = stitchArray.count
        var upcomingleftOffset = 0
        for row in 0..<(rowsNum) {
            var newRowMetadata = makeRowMetadata(stitchRow: stitchArray[row], rowNumber: row)
            newRowMetadata.leftOffset += upcomingleftOffset
            if newRowMetadata.leftIncDec > 0 && row > 0 {
                for prevRow in (0...(row-1)).reversed() {
                    allRowsMetaData[prevRow].leftOffset += newRowMetadata.leftIncDec
                }
            }
            if newRowMetadata.leftIncDec < 0 {
                upcomingleftOffset += abs(newRowMetadata.leftIncDec)
                newRowMetadata.transRowLeftOffset += upcomingleftOffset
            }
            allRowsMetaData.append(newRowMetadata)
        }
        return(allRowsMetaData)
    }

    private func makeRowMetadata(stitchRow: [String], rowNumber: Int) -> RowInfo {

        var rowData = RowInfo(row: stitchRow, rowIndex: rowNumber)
        rowData.leftIncDec = findLeftChanges(stitchRow: stitchRow)
        rowData.rightIncDec = findRightChanges(stitchRow: stitchRow)
        rowData.width = stitchRow.count
        if rowNumber == 0 {
            rowData.bottomLine = ChartConstructor().makeBottomRow(width: rowData.width)
        } else {
            rowData.bottomLine = ChartConstructor().makeMiddleRow(
                width: rowData.width,
                rDiff: rowData.rightIncDec,
                lDiff: rowData.leftIncDec
            )
        }
        rowData.stitchSymbols = ChartConstructor().makeStitchRow(row: rowData.row)
        return(rowData)
    }

    private func findLeftChanges(stitchRow: [String]) -> Int {
        let center = stitchRow.count/2
        let leftHalf = stitchRow[..<center]
        return(findChange(halfStitchRow: leftHalf))
    }

    private func findRightChanges(stitchRow: [String]) -> Int {
        let center = stitchRow.count/2
        let leftHalf = stitchRow[center...]
        return(findChange(halfStitchRow: leftHalf))
    }

    private func findChange(halfStitchRow: ArraySlice<String>) -> Int {
        var totalChange = 0
        for stitch in halfStitchRow {

            let lookupStitch: StitchInfo = try! getStitchInfo(stitch: stitch)
            totalChange += lookupStitch.incDecValue
        }
        return totalChange
    }
}
