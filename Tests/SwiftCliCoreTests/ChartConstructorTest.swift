import Foundation
import XCTest
@testable import SwiftCliCore

class TopLevelPrinterTests: XCTestCase {

    // Top Level Tests
    func testPrintTopLevelMany() throws {
        let result = ChartConstructor().makeTopRow(width: 4)
        XCTAssertEqual(result, "┌─┬─┬─┬─┐\n")
    }

    func testPrintTopLevelOne() throws {
        let result = ChartConstructor().makeTopRow(width: 1)
        XCTAssertEqual(result, "┌─┐\n")
    }

    func testPrintTopLevelZero() throws {
        let result = ChartConstructor().makeTopRow(width: 0)
        XCTAssertEqual(result, "\n")
    }

}
class BottomLevelPrinterTests: XCTestCase {

    // Bottom Level Tests
    func testPrintBottomLevelMany() throws {
        let result = ChartConstructor().makeBottomRow(width: 4)
        XCTAssertEqual(result, "└─┴─┴─┴─┘")
    }

    func testPrintBottomLevelOne() throws {
        let result = ChartConstructor().makeBottomRow(width: 1)
        XCTAssertEqual(result, "└─┘")
    }

    func testPrintBottomLevelZero() throws {
        let result = ChartConstructor().makeBottomRow(width: 0)
        XCTAssertEqual(result, "")
    }
}
class MiddleLevelPrinterTests: XCTestCase {

    // Middle-of-Rows Tests

    func testPrintMiddleLevelMany() throws {
        let result = ChartConstructor().makeMiddleRow(width: 4)
        XCTAssertEqual(result, "├─┼─┼─┼─┤\n")
    }

    func testPrintMiddleLevelOne() throws {
        let result = ChartConstructor().makeMiddleRow(width: 1)
        XCTAssertEqual(result, "├─┤\n")
    }

    func testPrintMiddleLevelZero() throws {
        let result = ChartConstructor().makeMiddleRow(width: 0)
        XCTAssertEqual(result, "\n")
    }

}
class StitchRowPrinterTests: XCTestCase {
    // Stitch Row Tests

    func testPrintStitchRowMany() throws {
        let result = ChartConstructor().makeStitchRow(row: ["k1", "k1", "p1", "p1", "k1", "k1"])
        XCTAssertEqual(result, "│ │ │-│-│ │ │\n")
    }

    func testPrintStitchRowOne() throws {
        let result = ChartConstructor().makeStitchRow(row: ["k1"])
        XCTAssertEqual(result, "│ │\n")
    }

    func testPrintStitchRowZero() throws {
        let result = ChartConstructor().makeStitchRow(row: [""])
        XCTAssertEqual(result, "\n")
    }

}

class RightDecreaseMiddlePrinterTests: XCTestCase {
    func testOneRightDecrease() throws {
        let result = ChartConstructor().makeMiddleRowStitchCountChange(width: 6, rDiff: -1, lDiff: 0)
        let expected = "├─┼─┼─┼─┼─┼─┼─┐\n"
        XCTAssertEqual(result, expected)

    }

    func testThreeRightDecrease() throws {
        let result = ChartConstructor().makeMiddleRowStitchCountChange(width: 3, rDiff: -3, lDiff: 0)
        let expected = "├─┼─┼─┼─┬─┬─┐\n"
        XCTAssertEqual(result, expected)

    }

    func testTwoRightDecrease() throws {
        let result = ChartConstructor().makeMiddleRowStitchCountChange(width: 3, rDiff: -2, lDiff: 0)
        let expected = "├─┼─┼─┼─┬─┐\n"
        XCTAssertEqual(result, expected)

    }

}

class FullChartPrinterTests: XCTestCase {
    // Full Chart Tests

    func testFullPatternOneRow() throws {
        let result = ChartConstructor().makeChart(stitchArray: [["k1", "k1", "p1", "p1", "k1", "k1"]])
        let expectedresult = """
┌─┬─┬─┬─┬─┬─┐
│ │ │-│-│ │ │
└─┴─┴─┴─┴─┴─┘
"""
        XCTAssertEqual(result, expectedresult)
    }
    func testFullPatternTwoRow() throws {
        let result = ChartConstructor().makeChart(stitchArray: [["k1", "k1", "p1", "p1", "k1", "k1"],
                                                                ["p1", "p1", "k1", "k1", "p1", "p1"]])
        let expectedresult = """
┌─┬─┬─┬─┬─┬─┐
│-│-│ │ │-│-│
├─┼─┼─┼─┼─┼─┤
│ │ │-│-│ │ │
└─┴─┴─┴─┴─┴─┘
"""
        XCTAssertEqual(result, expectedresult)
    }

    func testFullPatternRightSSKDecrease() throws {
        let result = ChartConstructor().makeChart(stitchArray: [["k1", "k1", "p1", "p1", "k1", "k1", "p1", "k1"],
                                                                ["k1", "k1", "p1", "p1", "k1", "k1", "ssk"],
                                                                ["k1", "k1", "p1", "p1", "k1", "ssk"]])
        let expectedresult = """
┌─┬─┬─┬─┬─┬─┐
│ │ │-│-│ │\\│
├─┼─┼─┼─┼─┼─┼─┐
│ │ │-│-│ │ │\\│
├─┼─┼─┼─┼─┼─┼─┼─┐
│ │ │-│-│ │ │-│ │
└─┴─┴─┴─┴─┴─┴─┴─┘
"""
        XCTAssertEqual(result, expectedresult)
    }

    func testFullPatternTripleRightSSKDecrease() throws {
        let result = ChartConstructor().makeChart(stitchArray: [["k1", "k1", "k1", "k1", "k1", "k1", "k1", "k1"],
                                                                ["k1", "k1", "ssk", "ssk", "ssk"]])
        let expectedresult = """
┌─┬─┬─┬─┬─┐
│ │ │\\│\\│\\│
├─┼─┼─┼─┼─┼─┬─┬─┐
│ │ │ │ │ │ │ │ │
└─┴─┴─┴─┴─┴─┴─┴─┘
"""
        XCTAssertEqual(result, expectedresult)
    }

}
