import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class TopLevelPrinterTests: XCTestCase {

    func testPrintTopLevelMany() throws {
        let result = ChartConstructor().makeTopRow(width: 4)
        let expectedOutput = "┌─┬─┬─┬─┐\n"
        expect(result).to(equal(expectedOutput))
    }

    func testPrintTopLevelOne() throws {
        let result = ChartConstructor().makeTopRow(width: 1)
        let expectedOutput = "┌─┐\n"
        expect(result).to(equal(expectedOutput))
    }

    func testPrintTopLevelZero() throws {
        let result = ChartConstructor().makeTopRow(width: 0)
        let expectedOutput = "\n"
        expect(result).to(equal(expectedOutput))
    }
}

class BottomLevelPrinterTests: XCTestCase {

    func testPrintBottomLevelMany() throws {
        let result = ChartConstructor().makeBottomRow(width: 4)
        let expectedOutput = "└─┴─┴─┴─┘"
        expect(result).to(equal(expectedOutput))
    }

    func testPrintBottomLevelOne() throws {
        let result = ChartConstructor().makeBottomRow(width: 1)
        let expectedOutput = "└─┘"
        expect(result).to(equal(expectedOutput))
    }

    func testPrintBottomLevelZero() throws {
        let result = ChartConstructor().makeBottomRow(width: 0)
        let expectedOutput = ""
        expect(result).to(equal(expectedOutput))
    }
}

class StitchRowPrinterTests: XCTestCase {

    func testPrintStitchRowMany() throws {
        let result = ChartConstructor().makeStitchRow(row: ["k1", "k1", "p1", "p1", "k1", "k1"])
        let expectedOutput = "│ │ │-│-│ │ │\n"
        expect(result).to(equal(expectedOutput))
    }

    func testPrintStitchRowOne() throws {
        let result = ChartConstructor().makeStitchRow(row: ["k1"])
        let expectedOutput = "│ │\n"
        expect(result).to(equal(expectedOutput))
    }
}

class RightDecreaseMiddlePrinterTests: XCTestCase {
    func testOneRightDecrease() throws {
        let result = ChartConstructor().makeMiddleRow(width: 6, rDiff: -1, lDiff: 0)
        let expectedOutput = "├─┼─┼─┼─┼─┼─┼─┐\n"
        expect(result).to(equal(expectedOutput))
    }

    func testThreeRightDecrease() throws {
        let result = ChartConstructor().makeMiddleRow(width: 3, rDiff: -3, lDiff: 0)
        let expectedOutput = "├─┼─┼─┼─┬─┬─┐\n"
        expect(result).to(equal(expectedOutput))
    }

    func testTwoRightDecrease() throws {
        let result = ChartConstructor().makeMiddleRow(width: 3, rDiff: -2, lDiff: 0)
        let expectedOutput = "├─┼─┼─┼─┬─┐\n"
        expect(result).to(equal(expectedOutput))
    }
}

class RightIncreaseMiddlePrinterTests: XCTestCase {
    func testOneRightIncrease() throws {
        let result = ChartConstructor().makeMiddleRow(width: 5, rDiff: 1, lDiff: 0)
        let expectedOutput = "├─┼─┼─┼─┼─┘\n"
        expect(result).to(equal(expectedOutput))
    }

    func testMultipleRightIncrease() throws {
        let result = ChartConstructor().makeMiddleRow(width: 7, rDiff: 3, lDiff: 0)
        let expectedOutput = "├─┼─┼─┼─┼─┴─┴─┘\n"
        expect(result).to(equal(expectedOutput))
    }
}

class LeftIncreaseTests: XCTestCase {
    func testOneLeftInc() throws {
        let result = ChartConstructor().makeMiddleRow(width: 5, rDiff: 0, lDiff: 1)
        let expectedOutput = "└─┼─┼─┼─┼─┤\n"
        expect(result).to(equal(expectedOutput))
    }

    func testManyLeftInc() throws {
        let result = ChartConstructor().makeMiddleRow(width: 7, rDiff: 0, lDiff: 3)
        let expectedOutput = "└─┴─┴─┼─┼─┼─┼─┤\n"
        expect(result).to(equal(expectedOutput))
    }
}

class LeftDecreaseTests: XCTestCase {
    func testOneLeftDec() throws {
        let result = ChartConstructor().makeMiddleRow(width: 4, rDiff: 0, lDiff: -1)
        let expectedOutput = "┌─┼─┼─┼─┼─┤\n"
        expect(result).to(equal(expectedOutput))
    }

    func testManyLeftDec() throws {
        let result = ChartConstructor().makeMiddleRow(width: 4, rDiff: 0, lDiff: -3)
        let expectedOutput = "┌─┬─┬─┼─┼─┼─┼─┤\n"
        expect(result).to(equal(expectedOutput))
    }
}

class LeftAndRightTests: XCTestCase {

    func testOneLeftDecOneRightInc() throws {
        let result = ChartConstructor().makeMiddleRow(width: 5, rDiff: 1, lDiff: -1)
        let expectedOutput = "┌─┼─┼─┼─┼─┼─┘\n"
        expect(result).to(equal(expectedOutput))
    }

    func testManyLeftDecManyRightDec() throws {
        let result = ChartConstructor().makeMiddleRow(width: 4, rDiff: -3, lDiff: -3)
        let expectedOutput = "┌─┬─┬─┼─┼─┼─┼─┼─┬─┬─┐\n"
        expect(result).to(equal(expectedOutput))
    }

    func testOneLeftIncOneRightInc() throws {
        let result = ChartConstructor().makeMiddleRow(width: 5, rDiff: 1, lDiff: 1)
        let expectedOutput = "└─┼─┼─┼─┼─┘\n"
        expect(result).to(equal(expectedOutput))
    }
}

class FullChartPrinterTests: XCTestCase {

    func testFullPatternOneRow() throws {
        let testArray = [["k1", "k1", "p1", "p1", "k1", "k1"]]
        let result = ChartConstructor().makeChart(stitchArray: testArray)
        let expectedOutput = """
┌─┬─┬─┬─┬─┬─┐
│ │ │-│-│ │ │
└─┴─┴─┴─┴─┴─┘
"""
        expect(result).to(equal(expectedOutput))
    }

    func testFullPatternTwoRow() throws {
        let testArray = [["k1", "k1", "p1", "p1", "k1", "k1"],
                        ["p1", "p1", "k1", "k1", "p1", "p1"]]
        let result = ChartConstructor().makeChart(stitchArray: testArray)
        let expectedOutput = """
┌─┬─┬─┬─┬─┬─┐
│-│-│ │ │-│-│
├─┼─┼─┼─┼─┼─┤
│ │ │-│-│ │ │
└─┴─┴─┴─┴─┴─┘
"""
        expect(result).to(equal(expectedOutput))
    }

    func testFullPatternRightSSKDecrease() throws {
        let testArray = [["k1", "k1", "p1", "p1", "k1", "k1", "p1", "k1"],
                         ["k1", "k1", "p1", "p1", "k1", "k1", "ssk"],
                         ["k1", "k1", "p1", "p1", "k1", "ssk"]]
        let result = ChartConstructor().makeChart(stitchArray: testArray)
        let expectedOutput = """
┌─┬─┬─┬─┬─┬─┐
│ │ │-│-│ │\\│
├─┼─┼─┼─┼─┼─┼─┐
│ │ │-│-│ │ │\\│
├─┼─┼─┼─┼─┼─┼─┼─┐
│ │ │-│-│ │ │-│ │
└─┴─┴─┴─┴─┴─┴─┴─┘
"""
        expect(result).to(equal(expectedOutput))
    }

    func testFullPatternTripleRightSSKDecrease() throws {
        let result = ChartConstructor().makeChart(stitchArray: [["k1", "k1", "k1", "k1", "k1", "k1", "k1", "k1"],
                                                                ["k1", "k1", "ssk", "ssk", "ssk"]])
        let expectedOutput = """
┌─┬─┬─┬─┬─┐
│ │ │\\│\\│\\│
├─┼─┼─┼─┼─┼─┬─┬─┐
│ │ │ │ │ │ │ │ │
└─┴─┴─┴─┴─┴─┴─┴─┘
"""
        expect(result).to(equal(expectedOutput))
    }

    func testFullPatternRightYOInc() throws {
        let testArray = [["p1", "k1", "k1", "k1"],
                         ["p1", "k1", "k1", "yo", "k1"],
                         ["p1", "k1", "k1", "k1", "yo", "k1"]]
        let result = ChartConstructor().makeChart(stitchArray: testArray)
        let expectedOutput = """
┌─┬─┬─┬─┬─┬─┐
│-│ │ │ │o│ │
├─┼─┼─┼─┼─┼─┘
│-│ │ │o│ │
├─┼─┼─┼─┼─┘
│-│ │ │ │
└─┴─┴─┴─┘
"""
        expect(result).to(equal(expectedOutput))
    }

    func testFullPatternRightMultipleInc() throws {
        let testArray = [["k1", "k1", "k1", "k1"],
                        ["k1", "k1", "k1", "yo", "m1", "k1"],
                        ["k1", "k1", "k1", "k1", "k1", "yo", "m1", "k1"]]
        let result = ChartConstructor().makeChart(stitchArray: testArray)
        let expectedOutput = """
┌─┬─┬─┬─┬─┬─┬─┬─┐
│ │ │ │ │ │o│m│ │
├─┼─┼─┼─┼─┼─┼─┴─┘
│ │ │ │o│m│ │
├─┼─┼─┼─┼─┴─┘
│ │ │ │ │
└─┴─┴─┴─┘
"""
        expect(result).to(equal(expectedOutput))
    }

    func testFullPatternLeftSingleInc() throws {
        let testArray = [["k1", "k1", "p1"],
                         ["k1", "yo", "k1", "p1"],
                         ["k1", "yo", "k1", "k1", "p1"]]
        let result = ChartConstructor().makeChart(stitchArray: testArray)

        let expectedOutput = """
┌─┬─┬─┬─┬─┐
│ │o│ │ │-│
└─┼─┼─┼─┼─┤
  │ │o│ │-│
  └─┼─┼─┼─┤
    │ │ │-│
    └─┴─┴─┘
"""
        expect(result).to(equal(expectedOutput))
    }

    func testFullPatternLeftRightSingleInc() throws {
        let testArray = [["k1", "k1", "k1"],
                         ["k1", "m1", "k1", "m1", "k1"]]
        let result = ChartConstructor().makeChart(stitchArray: testArray)
        let expectedOutput = """
┌─┬─┬─┬─┬─┐
│ │m│ │m│ │
└─┼─┼─┼─┼─┘
  │ │ │ │
  └─┴─┴─┘
"""
        expect(result).to(equal(expectedOutput))
    }


    func testFullPatternLeftDoubleInc() throws {
        let testArray = [["k1", "k1", "p1"],
                         [ "m1", "yo", "k1", "k1", "p1"]]
        let result = ChartConstructor().makeChart(stitchArray: testArray)
        let expectedOutput = """
┌─┬─┬─┬─┬─┐
│m│o│ │ │-│
└─┴─┼─┼─┼─┤
    │ │ │-│
    └─┴─┴─┘
"""
        expect(result).to(equal(expectedOutput))
    }
}
