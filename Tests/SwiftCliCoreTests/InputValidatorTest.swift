import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class ValidatorTests: XCTestCase {

    private var inputValidator: InputValidator!

    override func setUp() {
        super.setUp()
        inputValidator = InputValidator(patternNormalizer: PatternNormalizer(), nestedArrayBuilder: NestedArrayBuilder())
    }

    func testInvalidStitchShouldThrowError() throws {
        let testPattern = ["g1 p1"]
        let err = InputError.multipleErrors(errors:
                                    [
                                        SwiftCliCore.InputError.invalidStitch(
                                            invalidStitch: "g1",
                                            rowLocation: Optional(1),
                                            stitchIndexInRow: Optional(1))
                                    ])
        expect {
            try self.inputValidator.validateInput(
                pattern: testPattern,
                knitFlat: false)
        }
        .to(throwError(err))

    }

    func testEmptyRowShouldThrowError() throws {
        let testPattern = ["p1 p1", ""]
        expect {
            try self.inputValidator.validateInput(
                pattern: testPattern)

        }
        .to(throwError(InputError.emptyRow))
    }

    func testInvalidStitchCountShouldThrowError() throws {
        let badCountPattern = ["p1 p1", "p1 p1", "p1 p1", "p1 p1 p1"]

        let badCountError = InputError.invalidRowWidth(
            invalidRowNumber: 4,
            expectedStitchCount: 2,
            actualCount: 3)
        expect {
            try self.inputValidator.validateInput(
                pattern: badCountPattern)
        }
        .to(throwError(badCountError))

    }

    func testMultipleIncorrectStitchesTypesShouldThrowMultipleErrors() throws {
        let multipleIncorrectStitchesPattern = ["p1 p1", "g1 p1", "p1 g1", "g1 p1"]
       let error = InputError.multipleErrors(errors: [
        InputError.invalidStitch(
            invalidStitch: "g1",
            rowLocation: Optional(2),
            stitchIndexInRow: 1
        ),
        InputError.invalidStitch(
            invalidStitch: "g1",
            rowLocation: Optional(3),
            stitchIndexInRow: Optional(2)
        ),
        InputError.invalidStitch(
            invalidStitch: "g1",
            rowLocation: Optional(4),
            stitchIndexInRow: Optional(1)
        )])
        expect {
            try self.inputValidator.validateInput(
                pattern: multipleIncorrectStitchesPattern)
        }
        .to(throwError(error))
    }

    func testZeroCountStitchShouldThrowMultipleErrors() throws {
        let multipleIncorrectStitchesPattern = ["k0 p1"]
        let error = InputError.multipleErrors(errors: [
            InputError.invalidStitchNumber(
                rowNumber: Optional(1),
                invalidStitch: "k0",
                validStitchType: "k",
                invalidStitchNumber: "0",
                stitchIndexInRow: Optional(1)
            )
        ])
        expect {
            try self.inputValidator.validateInput(
                pattern: multipleIncorrectStitchesPattern)
        }
        .to(throwError(error))
    }


    func testValidPatternShouldReturnMetaData() throws {


        let result = try self.inputValidator.validateInput(
            pattern: ["p1 p1", "p1 p1"],
            knitFlat: false
        )

        let expectedResult = [
            RowInfo(
                row: ["p1", "p1"],
                rowIndex: 0,
                bottomLine: "└─┴─┘",
                stitchSymbols: "│-│-│\n",
                width: 2,
                leftIncDec: 0,
                rightIncDec: 0,
                leftOffset: 0
            ),
            RowInfo(
                row: ["p1", "p1"],
                rowIndex: 1,
                bottomLine: "├─┼─┤\n",
                stitchSymbols: "│-│-│\n",
                width: 2,
                leftIncDec: 0,
                rightIncDec: 0,
                leftOffset: 0
            )
        ]
        expect(result).to(equal(expectedResult))
    }

    func testValidPatternKnitFlatShouldReturnMetaData() throws {

        let result = try self.inputValidator.validateInput(
            pattern: ["k1 p1", "p1 k1"],
            knitFlat: true
        )

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

    func testValidPatternWithUpperCaseShouldReturnMetaData() throws {
        let result = try self.inputValidator.validateInput(
            pattern: ["K1 P1", "P1 K1"]
        )
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
                row: ["p1", "k1"],
                rowIndex: 1,
                bottomLine: "├─┼─┤\n",
                stitchSymbols: "│-│ │\n",
                width: 2,
                leftIncDec: 0,
                rightIncDec: 0,
                leftOffset: 0
            )
        ]
        expect(result).to(equal(expectedResult))
    }
}
