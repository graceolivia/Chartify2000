import Foundation

public struct RowInfo: Equatable {
    var row: [String]
    var rowNumber: Int
    var bottomLine: String = ""
    var stitchSymbols: String = ""
    var width: Int = 0
    var leftIncDec: Int = 0
    var rightIncDec: Int = 0
    // This is about the number of "empty stitches" that should be added on the left to account for future increases
    var leftOffset: Int = 0
    lazy var leftOffsetString: String = String(repeating: "  ", count: leftOffset)
    lazy var offsetBottomLine: String = leftOffsetString + bottomLine
    lazy var offsetStitchSymbols: String = leftOffsetString + stitchSymbols
    lazy var totalRow: String = offsetStitchSymbols + offsetBottomLine
}

public class MetaDataBuilder  {
    public init() {}

    public func gatherAllMetaData(stitchArray: [[String]]) -> [RowInfo] {
        var allRowsMetaData = [] as [RowInfo]
        let rowsNum = stitchArray.count
        for row in 0..<(rowsNum) {
            let newRowMetadata = makeRowMetadata(stitchRow: stitchArray[row], rowNumber: row)
            allRowsMetaData.append(newRowMetadata)
            if newRowMetadata.leftIncDec != 0 {
                for prevRow in (0...(row-1)).reversed() {
                    allRowsMetaData[prevRow].leftOffset += newRowMetadata.leftIncDec
                }
            }
        }
        return(allRowsMetaData)
    }


    public func makeRowMetadata(stitchRow: [String], rowNumber: Int) -> RowInfo {
        var rowData = RowInfo(row: stitchRow, rowNumber: rowNumber)
        rowData.leftIncDec = findLeftChanges(stitchRow: stitchRow)
        rowData.rightIncDec = findRightChanges(stitchRow: stitchRow)
        rowData.width = stitchRow.count
        if rowNumber == 0 {
            rowData.bottomLine = ChartConstructor().makeBottomRow(width: rowData.width)
        } else {
            rowData.bottomLine = ChartConstructor().makeMiddleRow(width: rowData.width,
                                                                  rDiff: rowData.rightIncDec,
                                                                  lDiff: rowData.leftIncDec)
        }
        rowData.stitchSymbols = ChartConstructor().makeStitchRow(row: rowData.row)
        return(rowData)
    }

    public func findCenter(stitchRow: [String]) -> Int {
        let center = floor(Double(stitchRow.count/2))
    return(Int(center))
    }

    public func findLeftChanges(stitchRow: [String]) -> Int {
        let center = findCenter(stitchRow: stitchRow)
        var totalLeftChange = 0
        for stitch in 0..<(center) {
            if increases.contains(stitchRow[stitch]) {
                totalLeftChange += 1
            }
            if decreases.contains(stitchRow[stitch]) {
                totalLeftChange += -1
            }
        }
        return(totalLeftChange)
    }

    public func findRightChanges(stitchRow: [String]) -> Int {
        let center = findCenter(stitchRow: stitchRow)
        var totalRightChange = 0
        for stitch in center..<(stitchRow.count) {
            if increases.contains(stitchRow[stitch]) {
                totalRightChange += 1
            }
            if decreases.contains(stitchRow[stitch]) {
                totalRightChange += -1
            }
        }
        return(totalRightChange)
    }

}
