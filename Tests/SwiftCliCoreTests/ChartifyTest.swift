import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class ChartifyFinishedTest: XCTestCase {

    func testRunValidatesTheInput() throws {
        let input = "p1 k1 k1 k1"
        let inputValidator = InputValidatorMock()
        
        Chartify().run(input: input, inputValidator: inputValidator)
        
        expect(inputValidator.validateWasCalled).to(equal(true))
        expect(inputValidator.validateArgument).to(equal(input))
    }
    
    func testRunTransformsTheInputIntoAnArrayIfInputIsValid() throws {
    
    }
    
    func testRunMakesTheChartIfInputIsValid() throws {
    
    }
    
    func testRunPrintsTheChartIfInputIsValid() throws {
    
    }
    
    func testRunPrintsAnErrorMessageIfInputIsInvalid() throws {
    
    }
    
    // Put this in its own file
    // A mock inherits from "superclass" you are testing
    
    class InputValidatorMock: InputValidator {
        
        public var validateWasCalled: Bool
        public var validateArgument: String
        
        override public init() {
            validateWasCalled = false
            validateArgument = ""
        }
        
        override public func validate(pattern: String) -> Bool {
            validateWasCalled = true
            validateArgument = pattern
            return true
        }
    }
    
}
