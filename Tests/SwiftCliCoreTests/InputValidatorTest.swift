
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
        let result : [[String]] = InputValidator().ArrayMaker(cleanedpattern: "k1 p1 \n k1 p1")
        let expected : [[String]] = [["k1", "p1"], ["k1", "p1"]]
        XCTAssertEqual(result, expected)
    }
    
    func testValidatorForManyRowInputs() throws {
        let result : [[String]] = InputValidator().ArrayMaker(cleanedpattern: "k1 p1 \n k1 p1 \n k1 p1 \n k1 p1 \n k1 p1 \n")
        let expected : [[String]] = [["k1", "p1"], ["k1", "p1"], ["k1", "p1"], ["k1", "p1"], ["k1", "p1"]]
        XCTAssertEqual(result, expected)
    }
    
    func testValidatorForExtraLinebreak() throws {
        let result : [[String]] = InputValidator().ArrayMaker(cleanedpattern: "k1 p1 \n")
        let expected : [[String]] = [["k1", "p1"]]
        XCTAssertEqual(result, expected)
    }
    
    func testValidatorForThreeExtraLinebreak() throws {
        let result : [[String]] = InputValidator().ArrayMaker(cleanedpattern: "k1 p1 \n \n \n")
        let expected : [[String]] = [["k1", "p1"]]
        XCTAssertEqual(result, expected)
    }
    
    func testValidatorForOneStitch() throws {
        let result : [[String]] = InputValidator().ArrayMaker(cleanedpattern: "k1")
        let expected : [[String]] = [["k1"]]
        XCTAssertEqual(result, expected)
    }
    
}

class findWidestTests: XCTestCase {
    func testValidatorForWidestRowMultiple() throws {
        let result = InputValidator().FindWidestRow(patternarray: [["k1", "p1"], ["k1", "p1", "k1"],["p1"]])
        XCTAssertEqual(result, 1)
    }
    
    func testValidatorForWidestRowSingle() throws {
        let result = InputValidator().FindWidestRow(patternarray: [["p1"]])
        XCTAssertEqual(result, 0)
    }
}


//class CenteredArrayMaker: XCTestCase {
//    func testCenteredArrayMakerDecrease() throws{
//        let result = InputValidator().CenteredArrayMaker(array: [["k1", "ssk"],["k1"]])
//        let expected = [["k1", "ssk"],["k1", "NOSTITCH"]]
//        let IsItTheSame = arrayCompare(array1: result, array2: expected)
//        XCTAssertEqual(IsItTheSame, true)
//    }

