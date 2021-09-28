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
        var topRowBars = ""
        if width > 0 {
            topRowBars += "┌"
            if width > 1 {
                topRowBars += String(repeating: "─┬", count: width - 1)

            }
            topRowBars += "─┐"
        }
        topRowBars += "\n"
        return(topRowBars)
    }
    public func makeMiddleRow(width: Int) -> String {
        var middleRowBars = ""
        if width > 0 {
            middleRowBars += "├"
            if width > 1 {
                middleRowBars += String(repeating: "─┼", count: width - 1)
            }
            middleRowBars += "─┤"
        }
        middleRowBars += "\n"
        return(middleRowBars)
    }

    public func makeMiddleRowStitchCountChange(width: Int, rDiff: Int, lDiff: Int) -> String {

        var middleRowBars = ""
        if width > 0 {
            middleRowBars += "├"
            if rDiff < 0 {
                middleRowBars += String(repeating: "─┼", count: (width))
                if abs(rDiff) >= 2 {
                    middleRowBars += String(repeating: "─┬", count: ((abs(rDiff))-1))

                }
                middleRowBars += "─┐"
            }
        }
        middleRowBars += "\n"
        return(middleRowBars)
    }

    public func makeBottomRow(width: Int) -> String {
        var bottomRowBars = ""
        if width > 0 {
            bottomRowBars += "└"
            if width > 1 {
                bottomRowBars += String(repeating: "─┴", count: width - 1)
            }
            bottomRowBars += "─┘"
        }
        return(bottomRowBars)
    }

    public func makeStitchRow(row: [String]) -> String {
        var stitchRowSymbols = ""
        if row[0] != "" {
            stitchRowSymbols += "│"
            for stitch in row {
                stitchRowSymbols += stitchPrinting[stitch] ?? ""
                stitchRowSymbols += "│"
            }
        }
        stitchRowSymbols += "\n"
        return(stitchRowSymbols)
    }
}
