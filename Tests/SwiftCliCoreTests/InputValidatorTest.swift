import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class ValidatorTests: XCTestCase {
    // Valid Input

    func testValidatorForP1Input() throws {
        expect(InputValidator().validate(pattern: "p1"))==true
    }
    func testValidatorForK1P1Input() throws {
        expect(InputValidator().validate(pattern: "k1 p1"))==true

    }

    func testValidatorForLineBreaks() throws {
        expect(InputValidator().validate(pattern: "k1 p1 \n"))==true
    }

    // Invalid Input
    func testValidatorForG1P1Input() throws {
        expect(InputValidator().validate(pattern: "g1 p1"))==false
    }

    func testValidatorFor0Input() throws {
        expect(InputValidator().validate(pattern: ""))==false
    }

    func testValidatorForMiscBadInput() throws {
        expect(InputValidator().validate(pattern: "3"))==false
    }

}

class ArrayMakerTests: XCTestCase {

    func testValidatorForTwoRowInput() throws {
        expect(InputValidator().arrayMaker(cleanedpattern: "k1 p1 \n k1 p1"))==[["k1", "p1"], ["k1", "p1"]]
    }

    func testValidatorForManyRowInputs() throws {
        expect(InputValidator().arrayMaker(cleanedpattern: "k1 p1 \n k1 p1 \n k1 p1 \n k1 p1 \n"))==[["k1", "p1"], ["k1", "p1"], ["k1", "p1"], ["k1", "p1"]]

    }

    func testValidatorForExtraLinebreak() throws {
        expect(InputValidator().arrayMaker(cleanedpattern: "k1 p1 \n")) == [["k1", "p1"]]
    }

    func testValidatorForThreeExtraLinebreak() throws {
        expect(InputValidator().arrayMaker(cleanedpattern: "k1 p1 \n \n \n"))==[["k1", "p1"]]

    }

    func testValidatorForOneStitch() throws {
        expect(InputValidator().arrayMaker(cleanedpattern: "k1"))==[["k1"]]
    }

}
