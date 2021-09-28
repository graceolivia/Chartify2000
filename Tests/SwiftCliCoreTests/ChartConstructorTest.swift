import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class TopLevelPrinterTests: XCTestCase {

    func testPrintTopLevelMany() throws {
        expect(ChartConstructor().makeTopRow(width: 4))=="┌─┬─┬─┬─┐\n"
    }

    func testPrintTopLevelOne() throws {
        expect(ChartConstructor().makeTopRow(width: 1))=="┌─┐\n"
    }

    func testPrintTopLevelZero() throws {
        expect(ChartConstructor().makeTopRow(width: 0))=="\n"
    }

}
class BottomLevelPrinterTests: XCTestCase {

    // Bottom Level Tests
    func testPrintBottomLevelMany() throws {
        expect(ChartConstructor().makeBottomRow(width: 4))=="└─┴─┴─┴─┘"
    }

    func testPrintBottomLevelOne() throws {
        expect(ChartConstructor().makeBottomRow(width: 1))=="└─┘"
    }

    func testPrintBottomLevelZero() throws {
        expect(ChartConstructor().makeBottomRow(width: 0))==""
    }
}
class MiddleLevelPrinterTests: XCTestCase {

    func testPrintMiddleLevelMany() throws {
        expect(ChartConstructor().makeMiddleRow(width: 4))=="├─┼─┼─┼─┤\n"
    }

    func testPrintMiddleLevelOne() throws {
        expect(ChartConstructor().makeMiddleRow(width: 1))=="├─┤\n"
    }

    func testPrintMiddleLevelZero() throws {
        expect(ChartConstructor().makeMiddleRow(width: 0))=="\n"
    }

}
class StitchRowPrinterTests: XCTestCase {

    func testPrintStitchRowMany() throws {
        expect(ChartConstructor().makeStitchRow(row: ["k1", "k1", "p1", "p1", "k1", "k1"]))=="│ │ │-│-│ │ │\n"
    }

    func testPrintStitchRowOne() throws {
        expect(ChartConstructor().makeStitchRow(row: ["k1"]))=="│ │\n"
    }

    func testPrintStitchRowZero() throws {
        expect(ChartConstructor().makeStitchRow(row: [""]))=="\n"
    }

}

class RightDecreaseMiddlePrinterTests: XCTestCase {
    func testOneRightDecrease() throws {
        expect(ChartConstructor().makeMiddleRowStitchCountChange(width: 6, rDiff: -1, lDiff: 0))=="├─┼─┼─┼─┼─┼─┼─┐\n"

    }

    func testThreeRightDecrease() throws {
        expect(ChartConstructor().makeMiddleRowStitchCountChange(width: 3, rDiff: -3, lDiff: 0))=="├─┼─┼─┼─┬─┬─┐\n"


    }

    func testTwoRightDecrease() throws {
        expect(ChartConstructor().makeMiddleRowStitchCountChange(width: 3, rDiff: -2, lDiff: 0))=="├─┼─┼─┼─┬─┐\n"

    }

}

class FullChartPrinterTests: XCTestCase {
    // Full Chart Tests

    func testFullPatternOneRow() throws {
        expect(ChartConstructor().makeChart(stitchArray: [["k1", "k1", "p1", "p1", "k1", "k1"]]))=="""
┌─┬─┬─┬─┬─┬─┐
│ │ │-│-│ │ │
└─┴─┴─┴─┴─┴─┘
"""

    }
    func testFullPatternTwoRow() throws {
        expect(ChartConstructor().makeChart(stitchArray: [["k1", "k1", "p1", "p1", "k1", "k1"],
                                                          ["p1", "p1", "k1", "k1", "p1", "p1"]]))=="""
┌─┬─┬─┬─┬─┬─┐
│-│-│ │ │-│-│
├─┼─┼─┼─┼─┼─┤
│ │ │-│-│ │ │
└─┴─┴─┴─┴─┴─┘
"""

    }

    func testFullPatternRightSSKDecrease() throws {
        expect(ChartConstructor().makeChart(stitchArray: [["k1", "k1", "p1", "p1", "k1", "k1", "p1", "k1"],
                                                          ["k1", "k1", "p1", "p1", "k1", "k1", "ssk"],
                                                          ["k1", "k1", "p1", "p1", "k1", "ssk"]]))=="""
┌─┬─┬─┬─┬─┬─┐
│ │ │-│-│ │\\│
├─┼─┼─┼─┼─┼─┼─┐
│ │ │-│-│ │ │\\│
├─┼─┼─┼─┼─┼─┼─┼─┐
│ │ │-│-│ │ │-│ │
└─┴─┴─┴─┴─┴─┴─┴─┘
"""
    }

    func testFullPatternTripleRightSSKDecrease() throws {
        expect(ChartConstructor().makeChart(stitchArray: [["k1", "k1", "k1", "k1", "k1", "k1", "k1", "k1"],
                                                                ["k1", "k1", "ssk", "ssk", "ssk"]])) == """
┌─┬─┬─┬─┬─┐
│ │ │\\│\\│\\│
├─┼─┼─┼─┼─┼─┬─┬─┐
│ │ │ │ │ │ │ │ │
└─┴─┴─┴─┴─┴─┴─┴─┘
"""

    }

}
