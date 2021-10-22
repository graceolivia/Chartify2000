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

}
