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
        let topRowOffset = patternMetaData[lastRow].transRowLeftOffsetString
        let topRow = topRowOffset + makeTopRow(width: patternMetaData[lastRow].width)
        finishedChart = topRow  + finishedChart
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

        let rightStitches = rightSideStringBuilder(rDiff: rDiff)
        let leftStitches = leftSideStringBuilder(lDiff: lDiff)

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
        let middleStitches = String(repeating: "─┼", count: (width-totalIncreases-1))
        return leftStitches + middleStitches + rightStitches
    }

    private func leftSideStringBuilder(lDiff: Int) -> String {

        switch true {
        case (lDiff < -1):
            let midLeftSt = String(repeating: "┬─", count: ((abs(lDiff))-1))
            return("┌─\(midLeftSt)┼")
        case (lDiff == -1):
            return("┌─┼")
        case (lDiff == 1):
            return ("└─┼")
        case (lDiff >  1):
            let midLeftSt = String(repeating: "─┴", count: ((abs(lDiff))-1))
            return("└\(midLeftSt)─┼")
        default:
            return("├")
        }

    }

    private func rightSideStringBuilder(rDiff: Int) -> String {

        switch true {
        case (rDiff < -1):
            let midRightSt = String(repeating: "─┬", count: ((abs(rDiff))-1))
            return("─┼\(midRightSt)─┐\n")
        case (rDiff == -1):
            return("─┼─┐\n")
        case (rDiff == 1):
            return("─┼─┘\n")
        case (rDiff > 1):
            let midRightSt = String(repeating: "─┴", count: (rDiff-1))
            return("─┼\(midRightSt)─┘\n")
        default:
            return("─┤\n")
        }

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
                let getStitch = try! stitchLookup(stitch: stitch)
                middleStitches += "\(getStitch.symbol)│"
            }
            return "│\(middleStitches)\n"
        }

    }
}
