import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class PatternNormalizerTest: XCTestCase {

    func testMultipleStitchStringIsLowerCased() throws {
        let tryToNormalizeString = PatternNormalizer().makeAllLowercase(stitchesToLowercase: "P1 YO K1")
        expect(tryToNormalizeString).to(equal("p1 yo k1"))
    }

    func testOneStitchStringIsLowerCased() throws {
        let tryToNormalizeString = PatternNormalizer().makeAllLowercase(stitchesToLowercase: "K1")
        expect(tryToNormalizeString).to(equal("k1"))
    }

    func testInconsistentlyCapitalizedStringIsLowerCased() throws {
        let tryToNormalizeString = PatternNormalizer().makeAllLowercase(stitchesToLowercase: "k1 P1")
        expect(tryToNormalizeString).to(equal("k1 p1"))
    }

}
