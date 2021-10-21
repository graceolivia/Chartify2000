import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class FileValidatorTest: XCTestCase {
    func testBadSuffixThrowsError() throws {
        expect { try FileValidator().inputValidation(fileLocation: Optional("example.png")) }.to(throwError(FileUploadError.invalidFileType))
    }

    func testNilValueThrowsError() throws {
        expect { try FileValidator().inputValidation(fileLocation: Optional(nil)) }.to(throwError(FileUploadError.noFileError))
    }

    func testValidFileLocationReadsInFileAndReturnsArray() throws {
        let testInput: String? = "example.txt"
        let expectedArray = ["k1 k1 k1", "k1 p1 k1", "k1 k1 k1"]
        let callFileValidator = try FileValidator().inputValidation(fileLocation: testInput)
        expect(callFileValidator).to(equal(expectedArray))
    }

}
