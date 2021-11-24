import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class StitchLookupTest: XCTestCase {

    let stitchLibrary = StitchLibrary()

    func testStitchLookupNonRepeatingStitch() throws {
        let result = stitchLibrary.getStitchInfo(stitch: "ssk")
        let expectedResult = StitchType(name: "ssk", canRepeat: false, incDecValue: -1, symbol: "\\")
        expect(result).to(equal(expectedResult))
    }

    func testStitchLookupRepeatingStitch() throws {
        let result = stitchLibrary.getStitchInfo(stitch: "k1")
        let expectedResult = StitchType(name: "k", canRepeat: true, incDecValue: 0, symbol: " ")
        expect(result).to(equal(expectedResult))
    }


    func testIsStitchValidK5ReturnsTrue() throws {
        expect(self.stitchLibrary.isStitchValid(stitch: "k5")).to(equal(true))
    }

    func testIsStitchValidG5ReturnsFalse() throws {
        expect(self.stitchLibrary.isStitchValid(stitch: "g5")).to(equal(false))
    }

}
