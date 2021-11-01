import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class PatternNormalizerTest: XCTestCase {

    func testStringIsLowerCased() throws {
        let tryToNormalizeString = PatternNormalizer().makeAllLowercase(stitchesToLowercase: "P1 YO K1")
        expect(tryToNormalizeString).to(equal("p1 yo k1"))
    }

    func testStringIsLowerCasedd() throws {
        let tryToNormalizeString = PatternNormalizer().makeAllLowercase(stitchesToLowercase: "K1")
        expect(tryToNormalizeString).to(equal("k1"))
    }

}
