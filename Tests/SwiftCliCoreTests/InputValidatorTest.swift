import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class ValidatorTests: XCTestCase {

    func testValidatorForP1Input() throws {
        let result = InputValidator().validate(pattern: "p1")
        let expectedResult = true
        expect(result).to(equal(expectedResult))
    }

    func testValidatorForK1P1Input() throws {
        let result = InputValidator().validate(pattern: "k1 p1")
        let expectedResult = true
        expect(result).to(equal(expectedResult))
    }

    func testValidatorForLineBreaks() throws {
        let result = InputValidator().validate(pattern: "k1 p1 \n")
        let expectedResult = true
        expect(result).to(equal(expectedResult))
    }

    func testValidatorForG1P1Input() throws {
        let result = InputValidator().validate(pattern: "g1 p1")
        let expectedResult = false
        expect(result).to(equal(expectedResult))
    }

    func testValidatorFor0Input() throws {
        let result = InputValidator().validate(pattern: "")
        let expectedResult = false
        expect(result).to(equal(expectedResult))
    }

    func testValidatorForMiscBadInput() throws {
        let result = InputValidator().validate(pattern: "3")
        let expectedResult = false
        expect(result).to(equal(expectedResult))
    }

}

class ArrayMakerTests: XCTestCase {

    func testValidatorForTwoRowInput() throws {
        let result = InputValidator().arrayMaker(cleanedPattern: "k1 p1 \n k1 p1")
        let expectedResult = [["k1", "p1"], ["k1", "p1"]]
        expect(result).to(equal(expectedResult))
    }

    func testValidatorForManyRowInputs() throws {
        let result = InputValidator().arrayMaker(cleanedPattern: "k1 p1 \n k1 p1 \n k1 p1 \n k1 p1 \n")
        let expectedResult = [["k1", "p1"],
                              ["k1", "p1"],
                              ["k1", "p1"],
                              ["k1", "p1"]]
        expect(result).to(equal(expectedResult))
    }

    func testValidatorForExtraLinebreak() throws {
        let result = InputValidator().arrayMaker(cleanedPattern: "k1 p1 \n")
        let expectedResult = [["k1", "p1"]]
        expect(result).to(equal(expectedResult))
    }

    func testValidatorForThreeExtraLinebreak() throws {
        let result = InputValidator().arrayMaker(cleanedPattern: "k1 p1 \n \n \n")
        let expectedResult = [["k1", "p1"]]
        expect(result).to(equal(expectedResult))
    }

    func testValidatorForOneStitch() throws {
        let result = InputValidator().arrayMaker(cleanedPattern: "k1")
        let expectedResult = [["k1"]]
        expect(result).to(equal(expectedResult))
    }

}
