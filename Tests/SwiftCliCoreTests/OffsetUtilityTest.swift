import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class FindCenterTests: XCTestCase {

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
class FindLeftDecTests: XCTestCase {

    func testFindLeftDecForManyStitch() throws {
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

class FindRightDecTests: XCTestCase {

    func testFindRightDecForManyStitch() throws {
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

class MakeRowMetadataTests: XCTestCase {

    func testFindRightDecForManyStith() throws {
        let result = OffsetUtility().makeRowMetadata(stitchRow: ["k1", "yo", "k1", "p1", "k1", "p1", "yo", "k1"], rowNumber: 0, patternRowsCount: 1)
        let expectedResult = RowInfo(row: ["k1", "yo", "k1", "p1", "k1", "p1", "yo", "k1"],
                                     rowNumber: 0,
                                     bottomLine: "└─┴─┴─┴─┴─┴─┴─┴─┘",
                                     stitchSymbols: "│ │o│ │-│ │-│o│ │\n",
                                     width: 8,
                                     leftIncDec: 1,
                                     rightIncDec: 1,
                                     leftOffset: 0)
        expect(result).to(equal(expectedResult))
    }

}

class gatherAllMetaDataTests: XCTestCase {

    func testGatherAllMetaDataTests() throws {
        let result = OffsetUtility().gatherAllMetaData(stitchArray: [["k1", "p1"], ["k1", "p1"]])

        let expectedResult = [RowInfo(row: ["k1", "p1"],
                                     rowNumber: 0,
                                     bottomLine: "└─┴─┘",
                                     stitchSymbols: "│ │-│\n",
                                     width: 2,
                                     leftIncDec: 0,
                                     rightIncDec: 0,
                                     leftOffset: 0),
                              RowInfo(row: ["k1", "p1"],
                                       rowNumber: 1,
                                       bottomLine: "├─┼─┤\n",
                                       stitchSymbols: "│ │-│\n",
                                       width: 2,
                                       leftIncDec: 0,
                                       rightIncDec: 0,
                                       leftOffset: 0)]
        expect(result).to(equal(expectedResult))
    }

    func testGatherAllMetaDataTestsLeftInc() throws {
        let result = OffsetUtility().gatherAllMetaData(stitchArray: [["k1", "k1", "p1"], ["k1", "yo", "k1", "p1"]])

        let expectedResult = [RowInfo(row: ["k1", "k1", "p1"],
                                      rowNumber: 0,
                                      bottomLine: "└─┴─┴─┘",
                                      stitchSymbols: "│ │ │-│\n",
                                      width: 3,
                                      leftIncDec: 0,
                                      rightIncDec: 0,
                                      leftOffset: 1),
                              RowInfo(row: ["k1", "yo", "k1", "p1"],
                                      rowNumber: 1,
                                      bottomLine: "└─┼─┼─┼─┤\n",
                                      stitchSymbols: "│ │o│ │-│\n",
                                      width: 4,
                                      leftIncDec: 1,
                                      rightIncDec: 0,
                                      leftOffset: 0)]

        expect(result).to(equal(expectedResult))
    }

    func testGatherAllMetaDataTestsMultiLeftInc() throws {
        let result = OffsetUtility().gatherAllMetaData(stitchArray: [["k1", "k1", "p1"], ["k1", "yo", "k1", "p1"], ["k1", "yo", "k1", "k1", "p1"]])

        let expectedResult = [RowInfo(row: ["k1", "k1", "p1"],
                                      rowNumber: 0,
                                      bottomLine: "└─┴─┴─┘",
                                      stitchSymbols: "│ │ │-│\n",
                                      width: 3,
                                      leftIncDec: 0,
                                      rightIncDec: 0,
                                      leftOffset: 2),
                              RowInfo(row: ["k1", "yo", "k1", "p1"],
                                      rowNumber: 1,
                                      bottomLine: "└─┼─┼─┼─┤\n",
                                      stitchSymbols: "│ │o│ │-│\n",
                                      width: 4,
                                      leftIncDec: 1,
                                      rightIncDec: 0,
                                      leftOffset: 1),
                              RowInfo(row: ["k1", "yo", "k1", "k1", "p1"],
                                      rowNumber: 2,
                                      bottomLine: "└─┼─┼─┼─┼─┤\n",
                                      stitchSymbols: "│ │o│ │ │-│\n",
                                      width: 5,
                                      leftIncDec: 1,
                                      rightIncDec: 0,
                                      leftOffset: 0)]

        expect(result).to(equal(expectedResult))
    }

}
