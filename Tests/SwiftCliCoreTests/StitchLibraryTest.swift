import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class StitchLookupTest: XCTestCase {

    func testStitchLookupKnit() throws {
        let result = try getStitchInfo(stitch: "k1")
        let expectedResult = StitchInfo(name: "k1", incDecValue: 0, symbol: " ")
        expect(result).to(equal(expectedResult))
    }

    func testStitchLookupInvalid() throws {
        expect { try getStitchInfo(stitch: "g1") }.to(throwError())
    }

}
