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

}

class MultipleStitchExpanderTest: XCTestCase {

    func testExpandValidMultipleStitch() throws {
        let result = NestedArrayBuilder().expandRow(row: ["k4", "p1"])
        expect(result).to(equal(["k1", "k1", "k1", "k1", "p1"]))
    }


    func testValidNonExpandingStitchesDontExpand() throws {
        let result = NestedArrayBuilder().expandRow(row: ["k1", "p1"])
        expect(result).to(equal(["k1", "p1"]))
    }

    func testExpandValidRepeatStitch() throws {
        let result = NestedArrayBuilder().expandRow(row: ["k1", "p1", "(2x)"])
        expect(result).to(equal(["k1", "p1", "k1", "p1"]))
    }


}

