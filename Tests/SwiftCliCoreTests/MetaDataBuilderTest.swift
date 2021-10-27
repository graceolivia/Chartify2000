import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class BuildAllMetaDataTests: XCTestCase {

    func testBuildAllMetaDataTestNoIncDec() throws {
        let testArray = [["k1", "p1"],
                         ["k1", "p1"]]
        let result = MetaDataBuilder().buildAllMetaData(stitchArray: testArray)

        let expectedResult = [
            RowInfo(
                row: ["k1", "p1"],
                rowIndex: 0,
                bottomLine: "└─┴─┘",
                stitchSymbols: "│ │-│\n",
                width: 2,
                leftIncDec: 0,
                rightIncDec: 0,
                leftOffset: 0
            ),
            RowInfo(
                row: ["k1", "p1"],
                rowIndex: 1,
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

    func testBuildAllMetaDataTestSingleLeftInc() throws {
        let testArray = [["k1", "k1", "p1"],
                         ["k1", "yo", "k1", "p1"]]
        let result = MetaDataBuilder().buildAllMetaData(stitchArray: testArray)

        let expectedResult = [
            RowInfo(
                row: ["k1", "k1", "p1"],
                rowIndex: 0,
                bottomLine: "└─┴─┴─┘",
                stitchSymbols: "│ │ │-│\n",
                width: 3,
                leftIncDec: 0,
                rightIncDec: 0,
                leftOffset: 1
            ),
            RowInfo(
                row: ["k1", "yo", "k1", "p1"],
                rowIndex: 1,
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

    func testBuildAllMetaDataTestMultiLeftInc() throws {
        let testArray = [["k1", "k1", "p1"],
                         ["k1", "yo", "k1", "p1"],
                         ["k1", "yo", "k1", "k1", "p1"]]
        let result = MetaDataBuilder().buildAllMetaData(stitchArray: testArray)
        let expectedResult = [
            RowInfo(
                row: ["k1", "k1", "p1"],
                rowIndex: 0,
                bottomLine: "└─┴─┴─┘",
                stitchSymbols: "│ │ │-│\n",
                width: 3,
                leftIncDec: 0,
                rightIncDec: 0,
                leftOffset: 2
            ),
            RowInfo(
                row: ["k1", "yo", "k1", "p1"],
                rowIndex: 1,
                bottomLine: "└─┼─┼─┼─┤\n",
                stitchSymbols: "│ │o│ │-│\n",
                width: 4,
                leftIncDec: 1,
                rightIncDec: 0,
                leftOffset: 1
            ),
            RowInfo(
                row: ["k1", "yo", "k1", "k1", "p1"],
                rowIndex: 2,
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

    func testBuildAllMetaDataTestSingleRightInc() throws {
        let testArray = [["k1", "k1", "p1"],
                         ["k1", "k1", "yo", "p1"]]
        let result = MetaDataBuilder().buildAllMetaData(stitchArray: testArray)
        let expectedResult = [
            RowInfo(
                row: ["k1", "k1", "p1"],
                rowIndex: 0,
                bottomLine: "└─┴─┴─┘",
                stitchSymbols: "│ │ │-│\n",
                width: 3,
                leftIncDec: 0,
                rightIncDec: 0,
                leftOffset: 0
            ),
            RowInfo(
                row: ["k1", "k1", "yo", "p1"],
                rowIndex: 1,
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

    func testBuildAllMetaDataTestMultiRightInc() throws {
        let testArray = [["k1", "k1", "p1"],
                         ["k1", "k1", "yo", "m1", "p1"]]
        let result = MetaDataBuilder().buildAllMetaData(stitchArray: testArray)
        let expectedResult = [
            RowInfo(
                row: ["k1", "k1", "p1"],
                rowIndex: 0,
                bottomLine: "└─┴─┴─┘",
                stitchSymbols: "│ │ │-│\n",
                width: 3,
                leftIncDec: 0,
                rightIncDec: 0,
                leftOffset: 0
            ),
            RowInfo(
                row: ["k1", "k1", "yo", "m1", "p1"],
                rowIndex: 1,
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

    func testBuildAllMetaDataTestSingleRightDec() throws {
        let testArray = [["k1", "k1", "p1"],
                         ["k1", "ssk"]]
        let result = MetaDataBuilder().buildAllMetaData(stitchArray: testArray)
        let expectedResult = [
            RowInfo(
                row: ["k1", "k1", "p1"],
                rowIndex: 0,
                bottomLine: "└─┴─┴─┘",
                stitchSymbols: "│ │ │-│\n",
                width: 3,
                leftIncDec: 0,
                rightIncDec: 0,
                leftOffset: 0
            ),
            RowInfo(
                row: ["k1", "ssk"],
                rowIndex: 1,
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

    func testBuildAllMetaDataTestMultiRightDec() throws {
        let testArray = [["k1", "k1", "p1", "k1", "k1"],
                         ["k1", "ssk", "ssk"]]
        let result = MetaDataBuilder().buildAllMetaData(stitchArray: testArray)

        let expectedResult = [
            RowInfo(
                row: ["k1", "k1", "p1", "k1", "k1"],
                rowIndex: 0,
                bottomLine: "└─┴─┴─┴─┴─┘",
                stitchSymbols: "│ │ │-│ │ │\n",
                width: 5,
                leftIncDec: 0,
                rightIncDec: 0,
                leftOffset: 0
            ),
            RowInfo(
                row: ["k1", "ssk", "ssk"],
                rowIndex: 1,
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

class BuildAllMetaDataLazyValues: XCTestCase {

    func testBuildAllMetaDataLeftOffsetString() throws {
        let testArray = [["k1", "k1", "k1", "k1", "p1"],
                         ["k1", "m1", "yo", "k1", "k1", "k1", "p1"]]
        var testOffset = MetaDataBuilder().buildAllMetaData(stitchArray: testArray)

        let result = testOffset[0].leftOffsetString
        let expectedResult = "    "

        expect(result).to(equal(expectedResult))
    }

    func testBuildAllMetaDataTransRowLeftOffsetString() throws {
        let testArray = [["k1", "k1", "k1", "k1", "p1"],
                         ["k1", "m1", "yo", "k1", "k1", "k1", "p1"]]
        var testOffset = MetaDataBuilder().buildAllMetaData(stitchArray: testArray)

        let result = testOffset[0].transRowLeftOffsetString
        let expectedResult = ""

        expect(result).to(equal(expectedResult))
    }

    func testBuildAllMetaDataOffsetBottomLine() throws {
        let testArray = [["k1", "k1", "k1", "k1", "p1"],
                         ["k1", "m1", "yo", "k1", "k1", "k1", "p1"]]
        var testOffset = MetaDataBuilder().buildAllMetaData(stitchArray: testArray)

        let result = testOffset[0].offsetBottomLine
        let expectedResult = "    └─┴─┴─┴─┴─┘"

        expect(result).to(equal(expectedResult))
    }

    func testBuildAllMetaDataOffsetStitchSymbols() throws {
        let testArray = [["k1", "k1", "k1", "k1", "p1"],
                         ["k1", "m1", "yo", "k1", "k1", "k1", "p1"]]
        var testOffset = MetaDataBuilder().buildAllMetaData(stitchArray: testArray)

        let result = testOffset[0].offsetStitchSymbols
        let expectedResult = "    │ │ │ │ │-│\n"

        expect(result).to(equal(expectedResult))
    }

    func testBuildAllMetaDataTotalRow() throws {
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

    func testBuildAllMetaDataUserRowNumber() throws {
        let testArray = [["k1", "k1", "k1", "k1", "p1"],
                         ["k1", "k1", "k1", "k1", "p1"]]
        var testUserRowNumber = MetaDataBuilder().buildAllMetaData(stitchArray: testArray)

        let result = testUserRowNumber[0].userRowNumber
        let expectedResult = 1

        expect(result).to(equal(expectedResult))
    }
}
