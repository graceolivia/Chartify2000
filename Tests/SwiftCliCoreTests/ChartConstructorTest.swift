import Foundation
import XCTest
@testable import SwiftCliCore


class TopLevelPrinterTests: XCTestCase {
    
    // Top Level Tests
    func testPrintTopLevelMany() throws {
        let result = ChartConstructor().make_top_row(width: 4)
        XCTAssertEqual(result, "┌─┬─┬─┬─┐\n")
    }
    
    func testPrintTopLevelOne() throws {
        let result = ChartConstructor().make_top_row(width: 1)
        XCTAssertEqual(result, "┌─┐\n")
    }
    
    func testPrintTopLevelZero() throws {
        let result = ChartConstructor().make_top_row(width: 0)
        XCTAssertEqual(result, "\n")
    }
    
    
}
class BottomLevelPrinterTests: XCTestCase {
    
    // Bottom Level Tests
    func testPrintBottomLevelMany() throws {
        let result = ChartConstructor().make_bottom_row(width: 4)
        XCTAssertEqual(result, "└─┴─┴─┴─┘")
    }
    
    func testPrintBottomLevelOne() throws {
        let result = ChartConstructor().make_bottom_row(width: 1)
        XCTAssertEqual(result, "└─┘")
    }
    
    func testPrintBottomLevelZero() throws {
        let result = ChartConstructor().make_bottom_row(width: 0)
        XCTAssertEqual(result, "")
    }
}
class MiddleLevelPrinterTests: XCTestCase {
    
    // Middle-of-Rows Tests
    
    func testPrintMiddleLevelMany() throws {
        let result = ChartConstructor().make_middle_row(width: 4)
        XCTAssertEqual(result, "├─┼─┼─┼─┤\n")
    }
    
    func testPrintMiddleLevelOne() throws {
        let result = ChartConstructor().make_middle_row(width: 1)
        XCTAssertEqual(result, "├─┤\n")
    }
    
    func testPrintMiddleLevelZero() throws {
        let result = ChartConstructor().make_middle_row(width: 0)
        XCTAssertEqual(result, "\n")
    }
    
}
class StitchRowPrinterTests: XCTestCase {
    // Stitch Row Tests
    
    
    func testPrintStitchRowMany() throws {
        let result = ChartConstructor().make_stitch_row(row: ["k1", "k1", "p1", "p1", "k1", "k1"])
        XCTAssertEqual(result, "│ │ │-│-│ │ │\n")
    }
    
    func testPrintStitchRowOne() throws {
        let result = ChartConstructor().make_stitch_row(row: ["k1"])
        XCTAssertEqual(result, "│ │\n")
    }
    
    func testPrintStitchRowZero() throws {
        let result = ChartConstructor().make_stitch_row(row: [""])
        XCTAssertEqual(result, "\n")
    }
    
    
}
class FullChartPrinterTests: XCTestCase {
    // Full Chart Tests
    
    func testFullPatternOneRow() throws {
        let result = ChartConstructor().make_chart(stitch_array: [["k1", "k1", "p1", "p1", "k1", "k1"]])
        let expectedresult = """
┌─┬─┬─┬─┬─┬─┐
│ │ │-│-│ │ │
└─┴─┴─┴─┴─┴─┘
"""
        XCTAssertEqual(result, expectedresult)
    }
    func testFullPatternTwoRow() throws {
        let result = ChartConstructor().make_chart(stitch_array: [["k1", "k1", "p1", "p1", "k1", "k1"],["p1", "p1", "k1", "k1", "p1", "p1"]])
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
        let result = ChartConstructor().make_chart(stitch_array: [["k1", "k1", "p1", "p1", "k1", "k1", "p1", "ssk"],["k1", "k1", "p1", "p1", "k1", "k1", "ssk"],["k1", "k1", "p1", "p1", "k1", "k1"]])
        let expectedresult = """
┌─┬─┬─┬─┬─┬─┐
│ │ │-│-│ │ │
├─┼─┼─┼─┼─┼─┤─┐
│ │ │-│-│ │ │\\│
├─┼─┼─┼─┼─┼─┼─┤─┐
│ │ │-│-│ │ │-│\\│
└─┴─┴─┴─┴─┴─┴─┴─┘
"""
        XCTAssertEqual(result, expectedresult)
    }
//
//        func testFullPatternLeftK2togDecrease() throws {
//            let result = ChartConstructor().make_chart(stitch_array: [["k2tog", "k1", "p1", "p1", "k1", "k1"],["k1", "p1", "p1", "k1", "k1"]])
//            let expectedresult = """
//      ┌─┬─┬─┬─┬─┐
//      │ │-│-│ │ │
//    ┌─┼─┼─┼─┼─┼─┤
//    │/│ │-│-│ │ │
//    └─┴─┴─┴─┴─┴─┘
//    """
//            XCTAssertEqual(result, expectedresult)
//        }
//
//    func testFullPatternRight9YODecrease() throws {
//        let result = ChartConstructor().make_chart(stitch_array: [["k1", "p1", "k1", "yo"],["k1", "p1", "k1", "k1", "k1"]])
//        let expectedresult = """
//┌─┬─┬─┬─┬─┐
//│ │-│ │ │ │
//├─┼─┼─┼─┼─┘
//│ │-│ │o│
//└─┴─┴─┴─┘
//"""
//        XCTAssertEqual(result, expectedresult)
//    }
//
//    func testIncreaseAndDecrease() throws {
//        let result = ChartConstructor().make_chart(stitch_array: [["k2tog", "k1", "k1", "k1", "ssk"],["k2tog", "k1", "ssk"], ["k1"]])
//        let expectedresult = """
//    ┌─┐
//    │ │
//  ┌─┼─┼─┐
//  │/│ │\\│
//┌─┼─┼─┼─┤─┐
//│/│ │ │ │\\│
//└─┴─┴─┴─┴─┘
//"""
//        XCTAssertEqual(result, expectedresult)
//    }
//
    
    
}

