import Foundation

public class ChartConstructor {
    public init() {}
    public func makeChart(stitchArray: [[String]]) -> String {
        let lastRow = stitchArray.count - 1
        var patternMetaData = MetaDataBuilder().gatherAllMetaData(stitchArray: stitchArray)
        var finishedChart = ""
        for row in 0...lastRow {
            finishedChart = patternMetaData[row].totalRow + finishedChart
        }
            finishedChart = makeTopRow(width: patternMetaData[lastRow].width) + finishedChart
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

    public func makeMiddleRow(width: Int, rDiff: Int, lDiff: Int) -> String {
        var leftStitches = ""
        var rightStitches = ""
        var middleStitches = ""

        switch true {
        case (lDiff == 1):
            leftStitches = "└─┼"
        case (lDiff >  1):
            let midLeftSt = String(repeating: "─┴", count: ((abs(lDiff))-1))
            leftStitches = "└\(midLeftSt)─┼"
        default:
            leftStitches = "├"
        }

        var totalIncreases = 0

        switch true {
        case (lDiff > 0 && rDiff > 0):
            totalIncreases += rDiff
            totalIncreases += lDiff
        case (rDiff > 0):
            totalIncreases += rDiff
        case (lDiff > 0):
            totalIncreases += lDiff
        default:
            totalIncreases = 0
        }

        middleStitches = String(repeating: "─┼", count: (width-totalIncreases-1))

        switch true {
        case (rDiff < -1):
            let midRightSt = String(repeating: "─┬", count: ((abs(rDiff))-1))
            rightStitches = "─┼\(midRightSt)─┐\n"
        case (rDiff == -1):
            rightStitches = "─┼─┐\n"
        case (rDiff == 1):
            rightStitches = "─┼─┘\n"
        case (rDiff > 1):
            let midRightSt = String(repeating: "─┴", count: (rDiff-1))
            rightStitches = "─┼\(midRightSt)─┘\n"
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
