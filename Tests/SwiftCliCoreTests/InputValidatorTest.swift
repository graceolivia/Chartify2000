import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class ValidatorTests: XCTestCase {

    func testValidatorForP1Input() throws {
        let result = try InputValidator().validateEachStitch(row: "p1")
        let expectedResult = true
        expect(result).to(equal(expectedResult))
    }

    func testValidatorForK1P1Input() throws {
        let result =  try InputValidator().validateEachStitch(row: "k1 p1")
        let expectedResult = true
        expect(result).to(equal(expectedResult))
    }

    func testValidatorForG1P1Input() throws {
        expect { try InputValidator().validateEachStitch(row: "g1 p1") }.to(throwError())
    }

    func testValidatorFor0Input() throws {
        expect { try InputValidator().validateEachStitch(row: "") }.to(throwError())

    }

    func testValidatorForMiscBadInput() throws {
        expect { try InputValidator().validateEachStitch(row: "3") }.to(throwError())
    }

}

class ArrayMakerTests: XCTestCase {

    func testValidatorForTwoRowInput() throws {
        let result = try InputValidator().arrayMaker(cleanedRow: "k1 p1 k1 p1")
        let expectedResult = ["k1", "p1", "k1", "p1"]
        expect(result).to(equal(expectedResult))
    }

    func testValidatorForThreeExtraLineBreak() throws {
        let result = try InputValidator().arrayMaker(cleanedRow: "k1 p1")
        let expectedResult = ["k1", "p1"]
        expect(result).to(equal(expectedResult))
    }

    func testValidatorForOneStitch() throws {
        let result = try InputValidator().arrayMaker(cleanedRow: "k1")
        let expectedResult = ["k1"]
        expect(result).to(equal(expectedResult))
    }
}


class VerifyValidStitchCountChange: XCTestCase {

    func testValidStitchCountNoChange() throws {
        let rowOne = RowInfo(
            row: ["k1", "p1"],
            rowNumber: 0,
            bottomLine: "└─┴─┘",
            stitchSymbols: "│ │-│\n",
            width: 2,
            leftIncDec: 0,
            rightIncDec: 0,
            leftOffset: 0
        )
        let rowTwo = RowInfo(
            row: ["k1", "p1"],
            rowNumber: 1,
            bottomLine: "├─┼─┤\n",
            stitchSymbols: "│ │-│\n",
            width: 2,
            leftIncDec: 0,
            rightIncDec: 0,
            leftOffset: 0
        )


        let result = InputValidator().verifyValidRowStitchCount(prevRow: rowOne, currentRow: rowTwo)
        let expectedResult = true
        expect(result).to(equal(expectedResult))
    }


    func testValidStitchCountIncreaseChange() throws {
        let rowOne = RowInfo(
            row: ["k1", "k1", "k1", "k1", "k1"],
            rowNumber: 0,
            bottomLine: "└─┴─┴─┴─┴─┘",
            stitchSymbols: "│ │ │ │ │ │\n",
            width: 5,
            leftIncDec: 0,
            rightIncDec: 0,
            leftOffset: 0
        )
        let rowTwo = RowInfo(
            row: ["k1", "k1", "k1", "k1", "yo", "k1"],
            rowNumber: 1,
            bottomLine: "├─┼─┼─┼─┼─┼─┘\n",
            stitchSymbols: "│ │ │ │ │o│ │\n",
            width: 6,
            leftIncDec: 1,
            rightIncDec: 0,
            leftOffset: 0
        )


        let result = InputValidator().verifyValidRowStitchCount(prevRow: rowOne, currentRow: rowTwo)
        let expectedResult = true
        expect(result).to(equal(expectedResult))
    }

    func testValidStitchCountDecreaseChange() throws {
        let rowOne = RowInfo(
            row: ["k1", "k1", "k1", "k1", "k1"],
            rowNumber: 0,
            bottomLine: "└─┴─┴─┴─┴─┘",
            stitchSymbols: "│ │ │ │ │ │\n",
            width: 5,
            leftIncDec: 0,
            rightIncDec: 0,
            leftOffset: 0
        )
        let rowTwo = RowInfo(
            row: ["k1", "k1", "k1", "ssk"],
            rowNumber: 1,
            bottomLine: "├─┼─┼─┼─┐\n",
            stitchSymbols: "│ │ │ │\\│\n",
            width: 4,
            leftIncDec: -1,
            rightIncDec: 0,
            leftOffset: 0
        )


        let result = InputValidator().verifyValidRowStitchCount(prevRow: rowOne, currentRow: rowTwo)
        let expectedResult = true
        expect(result).to(equal(expectedResult))
    }

    func testInvalidStitchCountDecrease() throws {
        let rowOne = RowInfo(
            row: ["k1", "p1", "p1"],
            rowNumber: 0,
            bottomLine: "└─┴─┴─┘",
            stitchSymbols: "│ │-│-│\n",
            width: 3,
            leftIncDec: 0,
            rightIncDec: 0,
            leftOffset: 0
        )
        let rowTwo = RowInfo(
            row: ["k1"],
            rowNumber: 1,
            bottomLine: "├─┤\n",
            stitchSymbols: "│ │\n",
            width: 1,
            leftIncDec: 0,
            rightIncDec: 0,
            leftOffset: 0
        )


        let result = InputValidator().verifyValidRowStitchCount(prevRow: rowOne, currentRow: rowTwo)
        let expectedResult = false
        expect(result).to(equal(expectedResult))
    }

    func testInvalidStitchCountIncrease() throws {
        let rowOne = RowInfo(
            row: ["k1", "p1", "p1"],
            rowNumber: 0,
            bottomLine: "└─┴─┴─┘",
            stitchSymbols: "│ │-│-│\n",
            width: 3,
            leftIncDec: 0,
            rightIncDec: 0,
            leftOffset: 0
        )
        let rowTwo = RowInfo(
            row: ["k1", "p1", "p1", "k1", "p1"],
            rowNumber: 1,
            bottomLine: "├─┼─┼─┼─┼─┤\n",
            stitchSymbols: "│ │-│-│ │-│\n",
            width: 5,
            leftIncDec: 0,
            rightIncDec: 0,
            leftOffset: 0
        )


        let result = InputValidator().verifyValidRowStitchCount(prevRow: rowOne, currentRow: rowTwo)
        let expectedResult = false
        expect(result).to(equal(expectedResult))
    }
}

class FindInvalidRowCountChange: XCTestCase {
    func testValidPattern() throws {
        let sampleAllRowsMetaData = [
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
        let result = try InputValidator().validateEachRowWidth(allRowsMetaData: sampleAllRowsMetaData)
        let expectedResult = true
        expect(result).to(equal(expectedResult))
    }

    func testInvalidIncreasePattern() throws {
        let sampleAllRowsMetaData = [
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
                row: ["k1", "p1", "p1"],
                rowNumber: 1,
                bottomLine: "├─┼─┼─┤\n",
                stitchSymbols: "│ │-│-│\n",
                width: 3,
                leftIncDec: 0,
                rightIncDec: 0,
                leftOffset: 0
            )
        ]
        expect { try InputValidator().validateEachRowWidth(allRowsMetaData: sampleAllRowsMetaData) }.to(throwError(InputError.invalidRowWidth(invalidRowNumber: 1, expectedStitchCount: 2, actualCount: 3)))

    }
}
