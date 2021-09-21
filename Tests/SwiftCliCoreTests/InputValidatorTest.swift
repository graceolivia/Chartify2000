
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
