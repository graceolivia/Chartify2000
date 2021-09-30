import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class findCenterTests: XCTestCase {

    func testFindCenterForEvenRow() throws {
    let result = OffsetUtility().findCenter(stitchRow: ["k1", "p1", "k1", "p1"])
    let expectedResult = 2
    expect(result).to(equal(expectedResult))
    }

    func testFindCenterForOddRow() throws {
        let result = OffsetUtility().findCenter(stitchRow: ["k1", "p1", "k1", "p1", "k1", "p1", "k1"])
        let expectedResult = 3
        expect(result).to(equal(expectedResult))
    }
}
class findLeftDecTests: XCTestCase {

    func testFindLeftDecForManyStith() throws {
        let result = OffsetUtility().findLeftChanges(stitchRow: ["k1", "k2tog", "k1", "p1", "k1", "p1", "k1"])
        let expectedResult = -1
        expect(result).to(equal(expectedResult))
    }

    func testFindLeftDecForOddRow() throws {
        let result = OffsetUtility().findLeftChanges(stitchRow: ["k2tog", "k2tog", "k1", "p1", "k1", "p1", "k2tog"])
        let expectedResult = -2
        expect(result).to(equal(expectedResult))
    }

    func testFindLeftIncForOddRow() throws {
        let result = OffsetUtility().findLeftChanges(stitchRow: ["k1", "yo", "k1", "p1", "k1", "p1", "k1"])
        let expectedResult = 1
        expect(result).to(equal(expectedResult))
    }
    func testFindLeftIncForEvenRow() throws {
        let result = OffsetUtility().findLeftChanges(stitchRow: ["k1", "yo", "k1", "p1", "k1", "k1", "p1", "k1"])
        let expectedResult = 1
        expect(result).to(equal(expectedResult))
    }

}

class findRightDecTests: XCTestCase {

    func testFindRightDecForManyStith() throws {
        let result = OffsetUtility().findRightChanges(stitchRow: ["k1", "k2tog", "k1", "p1", "k1", "p1", "k2tog"])
        let expectedResult = -1
        expect(result).to(equal(expectedResult))
    }

    func testFindRightDecForOddRow() throws {
        let result = OffsetUtility().findRightChanges(stitchRow: ["k2tog", "k1", "k1", "k2tog", "k1", "p1", "k2tog"])
        let expectedResult = -2
        expect(result).to(equal(expectedResult))
    }

    func testFindRightIncForOddRow() throws {
        let result = OffsetUtility().findRightChanges(stitchRow: ["k1", "yo", "k1", "p1", "k1", "p1", "yo", "k1"])
        let expectedResult = 1
        expect(result).to(equal(expectedResult))
    }
    func testFindRightIncForEvenRow() throws {
        let result = OffsetUtility().findRightChanges(stitchRow: ["k1", "k1", "p1", "k1", "yo", "k1", "p1", "k1"])
        let expectedResult = 1
        expect(result).to(equal(expectedResult))
    }

}

