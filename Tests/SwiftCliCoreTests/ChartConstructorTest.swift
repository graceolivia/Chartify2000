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

    // Bottom Level Tests
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
class MiddleLevelPrinterTests: XCTestCase {

    func testPrintMiddleLevelMany() throws {
        let result = ChartConstructor().makeMiddleRow(width: 4)
        let expectedOutput = "├─┼─┼─┼─┤\n"
        expect(result).to(equal(expectedOutput))
    }

    func testPrintMiddleLevelOne() throws {
        let result = ChartConstructor().makeMiddleRow(width: 1)
        let expectedOutput = "├─┤\n"
        expect(result).to(equal(expectedOutput))
    }

    func testPrintMiddleLevelZero() throws {
        let result = ChartConstructor().makeMiddleRow(width: 0)
        let expectedOutput = "\n"
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
        let result = ChartConstructor().makeMiddleRowStitchCountChange(width: 6, rDiff: -1, lDiff: 0)
        let expectedOutput = "├─┼─┼─┼─┼─┼─┼─┐\n"
        expect(result).to(equal(expectedOutput))

    }

    func testThreeRightDecrease() throws {
        let result = ChartConstructor().makeMiddleRowStitchCountChange(width: 3, rDiff: -3, lDiff: 0)
        let expectedOutput = "├─┼─┼─┼─┬─┬─┐\n"
        expect(result).to(equal(expectedOutput))
    }

    func testTwoRightDecrease() throws {
        let result = ChartConstructor().makeMiddleRowStitchCountChange(width: 3, rDiff: -2, lDiff: 0)
        let expectedOutput = "├─┼─┼─┼─┬─┐\n"
        expect(result).to(equal(expectedOutput))

    }

}

class FullChartPrinterTests: XCTestCase {
    // Full Chart Tests

    func testFullPatternOneRow() throws {
        let result = ChartConstructor().makeChart(stitchArray: [["k1", "k1", "p1", "p1", "k1", "k1"]])
        let expectedOutput = """
┌─┬─┬─┬─┬─┬─┐
│ │ │-│-│ │ │
└─┴─┴─┴─┴─┴─┘
"""
        expect(result).to(equal(expectedOutput))

    }
    func testFullPatternTwoRow() throws {
        let result = ChartConstructor().makeChart(stitchArray: [["k1", "k1", "p1", "p1", "k1", "k1"],
                                                                ["p1", "p1", "k1", "k1", "p1", "p1"]])
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
        let result = ChartConstructor().makeChart(stitchArray: [["k1", "k1", "p1", "p1", "k1", "k1", "p1", "k1"],
                                                                ["k1", "k1", "p1", "p1", "k1", "k1", "ssk"],
                                                                ["k1", "k1", "p1", "p1", "k1", "ssk"]])
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

}
