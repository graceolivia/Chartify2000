
import Foundation
import XCTest
@testable import SwiftCliCore

class ValidatorTests: XCTestCase {
    func testValidatorForK1Input() throws {
        let result = Validator().validate(pattern: "k1")
        XCTAssertEqual(result, true)
    }
    func testValidatorForP1Input() throws {
        let result = Validator().validate(pattern: "k1")
        XCTAssertEqual(result, true)
    }
    func testValidatorForK1P1Input() throws {
        let result = Validator().validate(pattern: "k1 p1")
        XCTAssertEqual(result, true)
    }
    func testValidatorForG1P1Input() throws {
        let result = Validator().validate(pattern: "g1 p1")
        XCTAssertEqual(result, false)
    }
    
}

class ArrayMakerTests: XCTestCase {
    
    func testValidatorForTwoRowInput() throws {
        let result : [[String]] = Validator().ArrayMaker(cleanedpattern: "k1 p1 \n k1 p1")
        let expected : [[String]] = [["k1", "p1"], ["k1", "p1"]]
        print("Result:")
        print(result)
        print("Expected:")
        print(expected)
        var IsItTheSame : Bool! = nil
        if (result == expected){
            IsItTheSame = true
        }
        else{
            IsItTheSame = false
        }
        XCTAssertEqual(IsItTheSame, true)
    }
    
    func testValidatorForManyRowInputs() throws {
        let result : [[String]] = Validator().ArrayMaker(cleanedpattern: "k1 p1 \n k1 p1 \n k1 p1 \n k1 p1 \n k1 p1 \n")
        let expected : [[String]] = [["k1", "p1"], ["k1", "p1"], ["k1", "p1"], ["k1", "p1"], ["k1", "p1"]]
        print("Result:")
        print(result)
        print("Expected:")
        print(expected)
        var IsItTheSame : Bool! = nil
        if (result == expected){
            IsItTheSame = true
        }
        else{
            IsItTheSame = false
        }
        XCTAssertEqual(IsItTheSame, true)
    }
    
    func testValidatorForExtraLinebreak() throws {
        let result : [[String]] = Validator().ArrayMaker(cleanedpattern: "k1 p1 \n")
        let expected : [[String]] = [["k1", "p1"]]
        print("Result:")
        print(result)
        print("Expected:")
        print(expected)
        var IsItTheSame : Bool! = nil
        if (result == expected){
            IsItTheSame = true
        }
        else{
            IsItTheSame = false
        }
        XCTAssertEqual(IsItTheSame, true)
    }
    
    func testValidatorForOneStitch() throws {
        let result : [[String]] = Validator().ArrayMaker(cleanedpattern: "k1")
        let expected : [[String]] = [["k1"]]
        print("Result:")
        print(result)
        print("Expected:")
        print(expected)
        var IsItTheSame : Bool! = nil
        if (result == expected){
            IsItTheSame = true
        }
        else{
            IsItTheSame = false
        }
        XCTAssertEqual(IsItTheSame, true)
    }
    
}
