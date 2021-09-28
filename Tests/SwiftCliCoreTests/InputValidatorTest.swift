import Foundation
import XCTest
@testable import SwiftCliCore

class ValidatorTests: XCTestCase {
    // Valid Input

    func testValidatorForP1Input() throws {
        let result = InputValidator().validate(pattern: "p1")
        XCTAssertEqual(result, true)
    }
    func testValidatorForK1P1Input() throws {
        let result = InputValidator().validate(pattern: "k1 p1")
        XCTAssertEqual(result, true)
    }

    func testValidatorForLineBreaks() throws {
        let result = InputValidator().validate(pattern: "k1 p1 \n")
        XCTAssertEqual(result, true)
    }

    // Invalid Input
    func testValidatorForG1P1Input() throws {
        let result = InputValidator().validate(pattern: "g1 p1")
        XCTAssertEqual(result, false)
    }

    func testValidatorFor0Input() throws {
        let result = InputValidator().validate(pattern: "")
        XCTAssertEqual(result, false)
    }

    func testValidatorForMiscBadInput() throws {
        let result = InputValidator().validate(pattern: "3")
        XCTAssertEqual(result, false)
    }

}

class ArrayMakerTests: XCTestCase {

    func testValidatorForTwoRowInput() throws {
        let result: [[String]] = InputValidator().arrayMaker(cleanedpattern: "k1 p1 \n k1 p1")
        let expected: [[String]] = [["k1", "p1"], ["k1", "p1"]]
        XCTAssertEqual(result, expected)
    }

    func testValidatorForManyRowInputs() throws {
        let result: [[String]] = InputValidator().arrayMaker(cleanedpattern: "k1 p1 \n k1 p1 \n k1 p1 \n k1 p1 \n")
        let expected: [[String]] = [["k1", "p1"], ["k1", "p1"], ["k1", "p1"], ["k1", "p1"]]
        XCTAssertEqual(result, expected)
    }

    func testValidatorForExtraLinebreak() throws {
        let result: [[String]] = InputValidator().arrayMaker(cleanedpattern: "k1 p1 \n")
        let expected: [[String]] = [["k1", "p1"]]
        XCTAssertEqual(result, expected)
    }

    func testValidatorForThreeExtraLinebreak() throws {
        let result: [[String]] = InputValidator().arrayMaker(cleanedpattern: "k1 p1 \n \n \n")
        let expected: [[String]] = [["k1", "p1"]]
        XCTAssertEqual(result, expected)
    }

    func testValidatorForOneStitch() throws {
        let result: [[String]] = InputValidator().arrayMaker(cleanedpattern: "k1")
        let expected: [[String]] = [["k1"]]
        XCTAssertEqual(result, expected)
    }

}
