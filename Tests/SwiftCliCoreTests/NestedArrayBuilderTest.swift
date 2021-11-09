import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class NestedArrayMakerTest: XCTestCase {

    func testNestedArrayBuilderEmpty() throws {
        let result = NestedArrayBuilder().arrayMaker(row: "")
        expect(result).to(equal([]))
    }

    func testNestedArrayBuilder() throws {
        let result = NestedArrayBuilder().arrayMaker(row: "k1 k1 k1")
        expect(result).to(equal(["k1", "k1", "k1"]))
    }

    func testNestedArrayBuilderWithRepeats() throws {
        let result = NestedArrayBuilder().arrayMaker(row: "k1 p1 (2x)")
        expect(result).to(equal(["k1", "p1", "k1", "p1"]))
    }

    func testNestedArrayBuilderWithRepeatsMidRow() throws {
        let result = NestedArrayBuilder().arrayMaker(row: "k1 p1 (2x) yo k1")
        expect(result).to(equal(["k1", "p1", "k1", "p1", "yo", "k1"]))
    }

}

class MultipleStitchExpanderTest: XCTestCase {

    func testExpandValidMultipleStitch() throws {
        let result = try NestedArrayBuilder().expandRow(row: ["k4", "p1"])
        expect(result).to(equal(["k1", "k1", "k1", "k1", "p1"]))
    }

    func testInvalidZeroCountStitch() throws {
        expect{
            try NestedArrayBuilder().expandRow(row: ["k0", "p1"])
        }
        .to(throwError(
            InputError.invalidStitchNumber(
                rowNumber: nil,
                invalidStitch: "k0",
                validStitchType: "k",
                invalidStitchNumber: "0")
        ))
    }

    func testInvalidWordCountStitch() throws {
        expect{
            try NestedArrayBuilder().expandRow(row: ["kx", "py"])
        }
        .to(throwError(
            InputError.invalidStitchNumber(
                    rowNumber: nil,
                    invalidStitch: "kx",
                    validStitchType: "k",
                    invalidStitchNumber: "x")
        ))
    }

    class MultipleStitchExpanderTest: XCTestCase {
        func testExpandValidMultipleStitch() throws {
            let result = try NestedArrayBuilder().expandRow(row: ["k4", "p1"])
            expect(result).to(equal(["k1", "k1", "k1", "k1", "p1"]))
        }

    }

}
