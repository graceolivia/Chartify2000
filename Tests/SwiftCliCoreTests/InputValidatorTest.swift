import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class ValidatorTests: XCTestCase {

    func testValidatorForP1Input() throws {
        let result = try InputValidator().validate(pattern: "p1")
        let expectedResult = true
        expect(result).to(equal(expectedResult))
    }

    func testValidatorForK1P1Input() throws {
        let result =  try InputValidator().validate(pattern: "k1 p1")
        let expectedResult = true
        expect(result).to(equal(expectedResult))
    }

    func testValidatorForG1P1Input() throws {
        expect { try InputValidator().validate(pattern: "g1 p1") }.to(throwError())
    }

    func testValidatorFor0Input() throws {
        expect { try InputValidator().validate(pattern: "") }.to(throwError())

    }

    func testValidatorForMiscBadInput() throws {
        expect { try InputValidator().validate(pattern: "3") }.to(throwError())
    }

}

class ArrayMakerTests: XCTestCase {

    func testValidatorForTwoRowInput() throws {
        let result = try InputValidator().arrayMaker(cleanedRow: "k1 p1 k1 p1")
        let expectedResult = ["k1", "p1", "k1", "p1"]
        expect(result).to(equal(expectedResult))
    }

    func testValidatorForThreeExtraLineBreak() throws {
        let result = try InputValidator().arrayMaker(cleanedRow: "k1 p1")
        let expectedResult = ["k1", "p1"]
        expect(result).to(equal(expectedResult))
    }

    func testValidatorForOneStitch() throws {
        let result = try InputValidator().arrayMaker(cleanedRow: "k1")
        let expectedResult = ["k1"]
        expect(result).to(equal(expectedResult))
    }

}
