import Foundation

public class ChartConstructor {
    public init() {}
    public func makeChart(stitchArray: [[String]]) -> String {

        let numberOfRows = stitchArray.count
        var finishedChart = ""
        let lastRow = numberOfRows - 1

        for row in 0...lastRow {
            let rowLength = stitchArray[row].count

            if row == 0 {
                finishedChart =  makeBottomRow(width: rowLength) + finishedChart
                finishedChart = makeStitchRow(row: stitchArray[row]) + finishedChart
            } else {
                let prevRowLength = stitchArray[row - 1].count
                let rightSideDiff = (rowLength - prevRowLength)
                if rightSideDiff < 0 {
                    let middleLine = makeMiddleRowStitchCountChange(width: rowLength, rDiff: rightSideDiff, lDiff: 0)
                    finishedChart =  middleLine + finishedChart
                } else {
                    finishedChart = makeMiddleRow(width: rowLength) + finishedChart
                }

                finishedChart = makeStitchRow(row: stitchArray[row]) + finishedChart

            }

            if row == (numberOfRows - 1) {
                finishedChart = makeTopRow(width: rowLength) + finishedChart

            }

        }

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
        let leftStitches = "├"
        var rightStitches = ""
        var middleStitches = ""

        switch width {
        case 1:
            middleStitches = "─"
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
        default:
            rightStitches = "─┤\n"
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
