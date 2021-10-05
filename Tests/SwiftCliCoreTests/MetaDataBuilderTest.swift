import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class FindCenterTests: XCTestCase {

    func testFindCenterForEvenRow() throws {
        let result = MetaDataBuilder().findCenter(stitchRow: ["k1", "p1", "k1", "p1"])
        let expectedResult = 2
        expect(result).to(equal(expectedResult))
    }

    func testFindCenterForOddRow() throws {
        let result = MetaDataBuilder().findCenter(stitchRow: ["k1", "p1", "k1", "p1", "k1", "p1", "k1"])
        let expectedResult = 3
        expect(result).to(equal(expectedResult))
    }
}
class FindLeftDecTests: XCTestCase {

    func testFindLeftDecForManyStitch() throws {
        let result = MetaDataBuilder().findLeftChanges(stitchRow: ["k1", "k2tog", "k1", "p1", "k1", "p1", "k1"])
        let expectedResult = -1
        expect(result).to(equal(expectedResult))
    }

    func testFindLeftDecForOddRow() throws {
        let result = MetaDataBuilder().findLeftChanges(stitchRow: ["k2tog", "k2tog", "k1", "p1", "k1", "p1", "k2tog"])
        let expectedResult = -2
        expect(result).to(equal(expectedResult))
    }

    func testFindLeftIncForOddRow() throws {
        let result = MetaDataBuilder().findLeftChanges(stitchRow: ["k1", "yo", "k1", "p1", "k1", "p1", "k1"])
        let expectedResult = 1
        expect(result).to(equal(expectedResult))
    }
    func testFindLeftIncForEvenRow() throws {
        let result = MetaDataBuilder().findLeftChanges(stitchRow: ["k1", "yo", "k1", "p1", "k1", "k1", "p1", "k1"])
        let expectedResult = 1
        expect(result).to(equal(expectedResult))
    }

}

class FindRightDecTests: XCTestCase {

    func testFindRightDecForManyStitch() throws {
        let result = MetaDataBuilder().findRightChanges(stitchRow: ["k1", "k2tog", "k1", "p1", "k1", "p1", "k2tog"])
        let expectedResult = -1
        expect(result).to(equal(expectedResult))
    }

    func testFindRightDecForOddRow() throws {
        let result = MetaDataBuilder().findRightChanges(stitchRow: ["k2tog", "k1", "k1", "k2tog", "k1", "p1", "k2tog"])
        let expectedResult = -2
        expect(result).to(equal(expectedResult))
    }

    func testFindRightIncForOddRow() throws {
        let result = MetaDataBuilder().findRightChanges(stitchRow: ["k1", "yo", "k1", "p1", "k1", "p1", "yo", "k1"])
        let expectedResult = 1
        expect(result).to(equal(expectedResult))
    }
    func testFindRightIncForEvenRow() throws {
        let result = MetaDataBuilder().findRightChanges(stitchRow: ["k1", "k1", "p1", "k1", "yo", "k1", "p1", "k1"])
        let expectedResult = 1
        expect(result).to(equal(expectedResult))
    }

}

class MakeRowMetadataTests: XCTestCase {

    func testMetaDataBuilderOneIncEachSide() throws {
        let result = MetaDataBuilder().makeRowMetadata(stitchRow: ["k1", "yo", "k1", "p1", "k1", "p1", "yo", "k1"], rowNumber: 0)
        let expectedResult = RowInfo(
                                row: ["k1", "yo", "k1", "p1", "k1", "p1", "yo", "k1"],
                                rowNumber: 0,
                                bottomLine: "└─┴─┴─┴─┴─┴─┴─┴─┘",
                                stitchSymbols: "│ │o│ │-│ │-│o│ │\n",
                                width: 8,
                                leftIncDec: 1,
                                rightIncDec: 1,
                                leftOffset: 0)
        expect(result).to(equal(expectedResult))
    }

    func testMetaDataBuilderBottomRow() throws {
        let result = MetaDataBuilder().makeRowMetadata(stitchRow: ["k1", "yo", "k1", "p1", "k1", "p1", "yo", "k1"], rowNumber: 0)
        let expectedResult = RowInfo(
                                row: ["k1", "yo", "k1", "p1", "k1", "p1", "yo", "k1"],
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

    func testGatherAllMetaDataTestNoIncDec() throws {
        let result = MetaDataBuilder().gatherAllMetaData(stitchArray: [["k1", "p1"],
                                                                        ["k1", "p1"]])

        let expectedResult = [RowInfo(
                                row: ["k1", "p1"],
                                rowNumber: 0,
                                bottomLine: "└─┴─┘",
                                stitchSymbols: "│ │-│\n",
                                width: 2,
                                leftIncDec: 0,
                                rightIncDec: 0,
                                leftOffset: 0),
                              RowInfo(
                                row: ["k1", "p1"],
                                rowNumber: 1,
                                bottomLine: "├─┼─┤\n",
                                stitchSymbols: "│ │-│\n",
                                width: 2,
                                leftIncDec: 0,
                                rightIncDec: 0,
                                leftOffset: 0)]
        expect(result).to(equal(expectedResult))
    }

    func testGatherAllMetaDataTestSingleLeftInc() throws {
        let result = MetaDataBuilder().gatherAllMetaData(stitchArray: [["k1", "k1", "p1"],
                                                                        ["k1", "yo", "k1", "p1"]])

        let expectedResult = [RowInfo(
                                row: ["k1", "k1", "p1"],
                                rowNumber: 0,
                                bottomLine: "└─┴─┴─┘",
                                stitchSymbols: "│ │ │-│\n",
                                width: 3,
                                leftIncDec: 0,
                                rightIncDec: 0,
                                leftOffset: 1),
                              RowInfo(
                                row: ["k1", "yo", "k1", "p1"],
                                rowNumber: 1,
                                bottomLine: "└─┼─┼─┼─┤\n",
                                stitchSymbols: "│ │o│ │-│\n",
                                width: 4,
                                leftIncDec: 1,
                                rightIncDec: 0,
                                leftOffset: 0)]

        expect(result).to(equal(expectedResult))
    }

    func testGatherAllMetaDataTestMultiLeftInc() throws {
        let result = MetaDataBuilder().gatherAllMetaData(stitchArray: [["k1", "k1", "p1"],
                                                                        ["k1", "yo", "k1", "p1"],
                                                                        ["k1", "yo", "k1", "k1", "p1"]])

        let expectedResult = [RowInfo(
                                row: ["k1", "k1", "p1"],
                                rowNumber: 0,
                                bottomLine: "└─┴─┴─┘",
                                stitchSymbols: "│ │ │-│\n",
                                width: 3,
                                leftIncDec: 0,
                                rightIncDec: 0,
                                leftOffset: 2),
                              RowInfo(
                                row: ["k1", "yo", "k1", "p1"],
                                rowNumber: 1,
                                bottomLine: "└─┼─┼─┼─┤\n",
                                stitchSymbols: "│ │o│ │-│\n",
                                width: 4,
                                leftIncDec: 1,
                                rightIncDec: 0,
                                leftOffset: 1),
                              RowInfo(
                                row: ["k1", "yo", "k1", "k1", "p1"],
                                rowNumber: 2,
                                bottomLine: "└─┼─┼─┼─┼─┤\n",
                                stitchSymbols: "│ │o│ │ │-│\n",
                                width: 5,
                                leftIncDec: 1,
                                rightIncDec: 0,
                                leftOffset: 0)]

        expect(result).to(equal(expectedResult))
    }

    func testGatherAllMetaDataTestSingleRightInc() throws {
        let result = MetaDataBuilder().gatherAllMetaData(stitchArray: [["k1", "k1", "p1"],
                                                                        ["k1", "k1", "yo", "p1"]])

        let expectedResult = [RowInfo(
                                row: ["k1", "k1", "p1"],
                                rowNumber: 0,
                                bottomLine: "└─┴─┴─┘",
                                stitchSymbols: "│ │ │-│\n",
                                width: 3,
                                leftIncDec: 0,
                                rightIncDec: 0,
                                leftOffset: 0),
                              RowInfo(
                                row: ["k1", "k1", "yo", "p1"],
                                rowNumber: 1,
                                bottomLine: "├─┼─┼─┼─┘\n",
                                stitchSymbols: "│ │ │o│-│\n",
                                width: 4,
                                leftIncDec: 0,
                                rightIncDec: 1,
                                leftOffset: 0)]

        expect(result).to(equal(expectedResult))
    }

    func testGatherAllMetaDataTestMultiRightInc() throws {
        let result = MetaDataBuilder().gatherAllMetaData(stitchArray: [["k1", "k1", "p1"],
                                                                        ["k1", "k1", "yo", "m1", "p1"]])

        let expectedResult = [RowInfo(
                                row: ["k1", "k1", "p1"],
                                rowNumber: 0,
                                bottomLine: "└─┴─┴─┘",
                                stitchSymbols: "│ │ │-│\n",
                                width: 3,
                                leftIncDec: 0,
                                rightIncDec: 0,
                                leftOffset: 0),
                              RowInfo(
                                row: ["k1", "k1", "yo", "m1", "p1"],
                                rowNumber: 1,
                                bottomLine: "├─┼─┼─┼─┴─┘\n",
                                stitchSymbols: "│ │ │o│m│-│\n",
                                width: 5,
                                leftIncDec: 0,
                                rightIncDec: 2,
                                leftOffset: 0)]

        expect(result).to(equal(expectedResult))
    }

    func testGatherAllMetaDataTestSingleRightDec() throws {
        let result = MetaDataBuilder().gatherAllMetaData(stitchArray: [["k1", "k1", "p1"],
                                                                        ["k1", "ssk"]])

        let expectedResult = [RowInfo(
                                row: ["k1", "k1", "p1"],
                                rowNumber: 0,
                                bottomLine: "└─┴─┴─┘",
                                stitchSymbols: "│ │ │-│\n",
                                width: 3,
                                leftIncDec: 0,
                                rightIncDec: 0,
                                leftOffset: 0),
                              RowInfo(
                                row: ["k1", "ssk"],
                                rowNumber: 1,
                                bottomLine: "├─┼─┼─┐\n",
                                stitchSymbols: "│ │\\│\n",
                                width: 2,
                                leftIncDec: 0,
                                rightIncDec: -1,
                                leftOffset: 0)]

        expect(result).to(equal(expectedResult))
    }

    func testGatherAllMetaDataTestMultiRightDec() throws {
        let result = MetaDataBuilder().gatherAllMetaData(stitchArray: [["k1", "k1", "p1", "k1", "k1"],
                                                                        ["k1", "ssk", "ssk"]])

        let expectedResult = [RowInfo(
                                row: ["k1", "k1", "p1", "k1", "k1"],
                                rowNumber: 0,
                                bottomLine: "└─┴─┴─┴─┴─┘",
                                stitchSymbols: "│ │ │-│ │ │\n",
                                width: 5,
                                leftIncDec: 0,
                                rightIncDec: 0,
                                leftOffset: 0),
                              RowInfo(
                                row: ["k1", "ssk", "ssk"],
                                rowNumber: 1,
                                bottomLine: "├─┼─┼─┼─┬─┐\n",
                                stitchSymbols: "│ │\\│\\│\n",
                                width: 3,
                                leftIncDec: 0,
                                rightIncDec: -2,
                                leftOffset: 0)]

        expect(result).to(equal(expectedResult))
    }

}

class gatherAllMetaDataLazyValues: XCTestCase {

    func testGatherAllMetaDataLeftOffsetString() throws {
        var testOffset = MetaDataBuilder().gatherAllMetaData(stitchArray: [["k1", "k1", "k1", "k1", "p1"],
                                                                            ["k1", "m1", "yo", "k1", "k1", "k1", "p1"]
                                                                           ])
        let result = testOffset[0].leftOffsetString
        let expectedResult = "    "

        expect(result).to(equal(expectedResult))
    }

    func testGatherAllMetaDataTransRowLeftOffsetString() throws {
        var testOffset = MetaDataBuilder().gatherAllMetaData(stitchArray: [["k1", "k1", "k1", "k1", "p1"],
                                                                            ["k1", "m1", "yo", "k1", "k1", "k1", "p1"]
                                                                           ])
        let result = testOffset[0].transRowLeftOffsetString
        let expectedResult = ""

        expect(result).to(equal(expectedResult))
    }

    // ------

    func testGatherAllMetaDataOffsetBottomLine() throws {
        var testOffset = MetaDataBuilder().gatherAllMetaData(stitchArray: [["k1", "k1", "k1", "k1", "p1"],
                                                                            ["k1", "m1", "yo", "k1", "k1", "k1", "p1"]
                                                                           ])
        let result = testOffset[0].offsetBottomLine
        let expectedResult = "    └─┴─┴─┴─┴─┘"

        expect(result).to(equal(expectedResult))
    }

    func testGatherAllMetaDataOffsetStitchSymbols() throws {
        var testOffset = MetaDataBuilder().gatherAllMetaData(stitchArray: [["k1", "k1", "k1", "k1", "p1"],
                                                                            ["k1", "m1", "yo", "k1", "k1", "k1", "p1"]
                                                                           ])
        let result = testOffset[0].offsetStitchSymbols
        let expectedResult = "    │ │ │ │ │-│\n"

        expect(result).to(equal(expectedResult))
    }

    func testGatherAllMetaDataTotalRow() throws {
        var testOffset = MetaDataBuilder().gatherAllMetaData(stitchArray: [["k1", "k1", "k1", "k1", "p1"],
                                                                            ["k1", "m1", "yo", "k1", "k1", "k1", "p1"]
                                                                           ])
        let result = testOffset[0].totalRow
        print(result)
        let expectedResult = """
    │ │ │ │ │-│
    └─┴─┴─┴─┴─┘
"""

        expect(result).to(equal(expectedResult))
    }

}
