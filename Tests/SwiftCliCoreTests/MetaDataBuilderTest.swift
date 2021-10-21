import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class GatherAllMetaDataTests: XCTestCase {

    func testGatherAllMetaDataTestNoIncDec() throws {
        let testArray = [["k1", "p1"],
                         ["k1", "p1"]]
        let result = MetaDataBuilder().buildAllMetaData(stitchArray: testArray)

        let expectedResult = [
            RowInfo(
                row: ["k1", "p1"],
                rowNumber: 0,
                bottomLine: "└─┴─┘",
                stitchSymbols: "│ │-│\n",
                width: 2,
                leftIncDec: 0,
                rightIncDec: 0,
                leftOffset: 0
            ),
            RowInfo(
                row: ["k1", "p1"],
                rowNumber: 1,
                bottomLine: "├─┼─┤\n",
                stitchSymbols: "│ │-│\n",
                width: 2,
                leftIncDec: 0,
                rightIncDec: 0,
                leftOffset: 0
            )
        ]
        expect(result).to(equal(expectedResult))
    }

    func testGatherAllMetaDataTestSingleLeftInc() throws {
        let testArray = [["k1", "k1", "p1"],
                         ["k1", "yo", "k1", "p1"]]
        let result = MetaDataBuilder().buildAllMetaData(stitchArray: testArray)

        let expectedResult = [
            RowInfo(
                row: ["k1", "k1", "p1"],
                rowNumber: 0,
                bottomLine: "└─┴─┴─┘",
                stitchSymbols: "│ │ │-│\n",
                width: 3,
                leftIncDec: 0,
                rightIncDec: 0,
                leftOffset: 1
            ),
            RowInfo(
                row: ["k1", "yo", "k1", "p1"],
                rowNumber: 1,
                bottomLine: "└─┼─┼─┼─┤\n",
                stitchSymbols: "│ │o│ │-│\n",
                width: 4,
                leftIncDec: 1,
                rightIncDec: 0,
                leftOffset: 0
            )
        ]

        expect(result).to(equal(expectedResult))
    }

    func testGatherAllMetaDataTestMultiLeftInc() throws {
        let testArray = [["k1", "k1", "p1"],
                         ["k1", "yo", "k1", "p1"],
                         ["k1", "yo", "k1", "k1", "p1"]]
        let result = MetaDataBuilder().buildAllMetaData(stitchArray: testArray)
        let expectedResult = [
            RowInfo(
                row: ["k1", "k1", "p1"],
                rowNumber: 0,
                bottomLine: "└─┴─┴─┘",
                stitchSymbols: "│ │ │-│\n",
                width: 3,
                leftIncDec: 0,
                rightIncDec: 0,
                leftOffset: 2
            ),
            RowInfo(
                row: ["k1", "yo", "k1", "p1"],
                rowNumber: 1,
                bottomLine: "└─┼─┼─┼─┤\n",
                stitchSymbols: "│ │o│ │-│\n",
                width: 4,
                leftIncDec: 1,
                rightIncDec: 0,
                leftOffset: 1
            ),
            RowInfo(
                row: ["k1", "yo", "k1", "k1", "p1"],
                rowNumber: 2,
                bottomLine: "└─┼─┼─┼─┼─┤\n",
                stitchSymbols: "│ │o│ │ │-│\n",
                width: 5,
                leftIncDec: 1,
                rightIncDec: 0,
                leftOffset: 0
            )
        ]

        expect(result).to(equal(expectedResult))
    }

    func testGatherAllMetaDataTestSingleRightInc() throws {
        let testArray = [["k1", "k1", "p1"],
                         ["k1", "k1", "yo", "p1"]]
        let result = MetaDataBuilder().buildAllMetaData(stitchArray: testArray)
        let expectedResult = [
            RowInfo(
                row: ["k1", "k1", "p1"],
                rowNumber: 0,
                bottomLine: "└─┴─┴─┘",
                stitchSymbols: "│ │ │-│\n",
                width: 3,
                leftIncDec: 0,
                rightIncDec: 0,
                leftOffset: 0
            ),
            RowInfo(
                row: ["k1", "k1", "yo", "p1"],
                rowNumber: 1,
                bottomLine: "├─┼─┼─┼─┘\n",
                stitchSymbols: "│ │ │o│-│\n",
                width: 4,
                leftIncDec: 0,
                rightIncDec: 1,
                leftOffset: 0
            )
        ]

        expect(result).to(equal(expectedResult))
    }

    func testGatherAllMetaDataTestMultiRightInc() throws {
        let testArray = [["k1", "k1", "p1"],
                         ["k1", "k1", "yo", "m1", "p1"]]
        let result = MetaDataBuilder().buildAllMetaData(stitchArray: testArray)
        let expectedResult = [
            RowInfo(
                row: ["k1", "k1", "p1"],
                rowNumber: 0,
                bottomLine: "└─┴─┴─┘",
                stitchSymbols: "│ │ │-│\n",
                width: 3,
                leftIncDec: 0,
                rightIncDec: 0,
                leftOffset: 0
            ),
            RowInfo(
                row: ["k1", "k1", "yo", "m1", "p1"],
                rowNumber: 1,
                bottomLine: "├─┼─┼─┼─┴─┘\n",
                stitchSymbols: "│ │ │o│m│-│\n",
                width: 5,
                leftIncDec: 0,
                rightIncDec: 2,
                leftOffset: 0
            )
        ]
        expect(result).to(equal(expectedResult))
    }

    func testGatherAllMetaDataTestSingleRightDec() throws {
        let testArray = [["k1", "k1", "p1"],
                         ["k1", "ssk"]]
        let result = MetaDataBuilder().buildAllMetaData(stitchArray: testArray)
        let expectedResult = [
            RowInfo(
                row: ["k1", "k1", "p1"],
                rowNumber: 0,
                bottomLine: "└─┴─┴─┘",
                stitchSymbols: "│ │ │-│\n",
                width: 3,
                leftIncDec: 0,
                rightIncDec: 0,
                leftOffset: 0
            ),
            RowInfo(
                row: ["k1", "ssk"],
                rowNumber: 1,
                bottomLine: "├─┼─┼─┐\n",
                stitchSymbols: "│ │\\│\n",
                width: 2,
                leftIncDec: 0,
                rightIncDec: -1,
                leftOffset: 0
            )
        ]

        expect(result).to(equal(expectedResult))
    }

    func testGatherAllMetaDataTestMultiRightDec() throws {
        let testArray = [["k1", "k1", "p1", "k1", "k1"],
                         ["k1", "ssk", "ssk"]]
        let result = MetaDataBuilder().buildAllMetaData(stitchArray: testArray)

        let expectedResult = [
            RowInfo(
                row: ["k1", "k1", "p1", "k1", "k1"],
                rowNumber: 0,
                bottomLine: "└─┴─┴─┴─┴─┘",
                stitchSymbols: "│ │ │-│ │ │\n",
                width: 5,
                leftIncDec: 0,
                rightIncDec: 0,
                leftOffset: 0
            ),
            RowInfo(
                row: ["k1", "ssk", "ssk"],
                rowNumber: 1,
                bottomLine: "├─┼─┼─┼─┬─┐\n",
                stitchSymbols: "│ │\\│\\│\n",
                width: 3,
                leftIncDec: 0,
                rightIncDec: -2,
                leftOffset: 0
            )
        ]
        expect(result).to(equal(expectedResult))
    }
}

class GatherAllMetaDataLazyValues: XCTestCase {

    func testGatherAllMetaDataLeftOffsetString() throws {
        let testArray = [["k1", "k1", "k1", "k1", "p1"],
                         ["k1", "m1", "yo", "k1", "k1", "k1", "p1"]]
        var testOffset = MetaDataBuilder().buildAllMetaData(stitchArray: testArray)
        let result = testOffset[0].leftOffsetString
        let expectedResult = "    "

        expect(result).to(equal(expectedResult))
    }

    func testGatherAllMetaDataTransRowLeftOffsetString() throws {
        let testArray = [["k1", "k1", "k1", "k1", "p1"],
                         ["k1", "m1", "yo", "k1", "k1", "k1", "p1"]]
        var testOffset = MetaDataBuilder().buildAllMetaData(stitchArray: testArray)
        let result = testOffset[0].transRowLeftOffsetString
        let expectedResult = ""

        expect(result).to(equal(expectedResult))
    }

    func testGatherAllMetaDataOffsetBottomLine() throws {
        let testArray = [["k1", "k1", "k1", "k1", "p1"],
                         ["k1", "m1", "yo", "k1", "k1", "k1", "p1"]]
        var testOffset = MetaDataBuilder().buildAllMetaData(stitchArray: testArray)
        let result = testOffset[0].offsetBottomLine
        let expectedResult = "    └─┴─┴─┴─┴─┘"

        expect(result).to(equal(expectedResult))
    }

    func testGatherAllMetaDataOffsetStitchSymbols() throws {
        let testArray = [["k1", "k1", "k1", "k1", "p1"],
                         ["k1", "m1", "yo", "k1", "k1", "k1", "p1"]]
        var testOffset = MetaDataBuilder().buildAllMetaData(stitchArray: testArray)
        let result = testOffset[0].offsetStitchSymbols
        let expectedResult = "    │ │ │ │ │-│\n"

        expect(result).to(equal(expectedResult))
    }

    func testGatherAllMetaDataTotalRow() throws {
        let testArray = [["k1", "k1", "k1", "k1", "p1"],
                         ["k1", "m1", "yo", "k1", "k1", "k1", "p1"]]
        var testOffset = MetaDataBuilder().buildAllMetaData(stitchArray: testArray)
        let result = testOffset[0].totalRow
        let expectedResult = """
    │ │ │ │ │-│
    └─┴─┴─┴─┴─┘
"""
        expect(result).to(equal(expectedResult))
    }
}
