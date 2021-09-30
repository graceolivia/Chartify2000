import Foundation

public class ChartConstructor {
    public init() {}
    public func makeChart(stitchArray: [[String]]) -> String {
        let lastRow = stitchArray.count - 1
        var patternMetaData = OffsetUtility().gatherAllMetaData(stitchArray: stitchArray)
        var finishedChart = ""
        for row in 0...lastRow{
            finishedChart = patternMetaData[row].totalRow + finishedChart
            if row == (lastRow) {
                finishedChart = makeTopRow(width: patternMetaData[row].width) + finishedChart
            }
        }
//
//        let numberOfRows = stitchArray.count
//        var finishedChart = ""
//        let lastRow = numberOfRows - 1
//
//        for row in 0...lastRow {
//            let rowLength = stitchArray[row].count
//            if row == 0 {
//                finishedChart = makeBottomRow(width: rowLength) + finishedChart
//                finishedChart = makeStitchRow(row: stitchArray[row]) + finishedChart
//            } else {
//                let prevRowLength = stitchArray[row - 1].count
//                let rightSideDiff = (rowLength - prevRowLength)
//                if rightSideDiff != 0 {
//                    let middleLine = makeMiddleRowStitchCountChange(width: rowLength, rDiff: rightSideDiff, lDiff: 0)
//                    finishedChart =  middleLine + finishedChart
//                } else {
//                    finishedChart = makeMiddleRow(width: rowLength) + finishedChart
//                }
//
//                finishedChart = makeStitchRow(row: stitchArray[row]) + finishedChart
//            }
//            if row == (lastRow) {
//                finishedChart = makeTopRow(width: rowLength) + finishedChart
//            }
//        }
        return(finishedChart)
    }

    



    public func makeTopRow(width: Int) -> String {
        switch width {
        case 0:
            return "\n"
        case 1:
            return "┌─┐\n"
        default:
            let middleBoxes = String(repeating: "─┬", count: width - 1)
            return "┌\(middleBoxes)─┐\n"
        }

    }
    public func makeMiddleRow(width: Int) -> String {
        switch width {
        case 0:
            return "\n"
        case 1:
            return "├─┤\n"
        default:
            let middleBoxes = String(repeating: "─┼", count: width - 1)
            return "├\(middleBoxes)─┤\n"
        }
    }

    public func makeMiddleRowStitchCountChange(width: Int, rDiff: Int, lDiff: Int) -> String {
        var leftStitches = ""
        var rightStitches = ""
        var middleStitches = ""
        switch true {
        case (lDiff > 0 && rDiff > 0):
            middleStitches = String(repeating: "─┼", count: (width-rDiff-lDiff-1))
        case (rDiff > 0):
            middleStitches = String(repeating: "─┼", count: (width-rDiff-1))
        case (lDiff > 0):
            middleStitches = String(repeating: "─┼", count: (width-lDiff-1))
        default:
            middleStitches = String(repeating: "─┼", count: (width-1))
        }

        switch true {
        case (rDiff < -1):
            let midRightSt = String(repeating: "─┬", count: ((abs(rDiff))-1))
            rightStitches = "─┼\(midRightSt)─┐\n"
        case (rDiff == -1):
            rightStitches = "─┼─┐\n"
        case (rDiff == 0):
            rightStitches = "─┤\n"
        case (rDiff == 1):
            rightStitches = "─┼─┘\n"
        case (rDiff > 1):
            let midRightSt = String(repeating: "─┴", count: ((abs(rDiff))-1))
            rightStitches = "─┼\(midRightSt)─┘\n"
        default:
            rightStitches = "─┤\n"
        }


        switch true {
        case (lDiff == 0):
            leftStitches = "├"
        case (lDiff == 1):
            leftStitches = "└─┼"
        case (lDiff >  1):
            let midLeftSt = String(repeating: "─┴", count: ((abs(lDiff))-1))
            leftStitches = "└\(midLeftSt)─┼"
        default:
            leftStitches = "├"
        }


        return leftStitches + middleStitches + rightStitches

    }

    public func makeBottomRow(width: Int) -> String {
        switch width {
        case 0:
            return ""
        case 1:
            return "└─┘"
        default:
            let middleBoxes = String(repeating: "─┴", count: width - 1)
            return "└\(middleBoxes)─┘"
        }
    }

    public func makeStitchRow(row: [String]) -> String {
        let width = row.count
        switch width {
        case 0:
            return "\n"
        default:
            var middleStitches = ""
            for stitch in row {
                middleStitches += "\(stitchPrinting[stitch] ?? "")│"
            }
            return "│\(middleStitches)\n"
        }

    }
}
