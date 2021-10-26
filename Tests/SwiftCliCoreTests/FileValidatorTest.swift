import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class FileValidatorTest: XCTestCase {
    func testBadSuffixThrowsError() throws {
        expect { try FileValidator().inputValidation(fileLocation: "example.png") }.to(throwError(ReadFilePath.invalidFileType))
    }

}
