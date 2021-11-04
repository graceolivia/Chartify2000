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

    override func tearDown() {
        inputValidator = nil
        super.tearDown()
    }

    func testInvalidStitchShouldThrowError() throws {
        let testPattern = ["g1 p1"]
        let err = InputError.invalidStitch(invalidStitch: "g1", rowLocation: 1)
        expect { try self.inputValidator.inputValidation(
            pattern: testPattern,
            knitFlat: false)
        }
        .to(throwError(err))
    }

    func testEmptyRowShouldThrowError() throws {
        let testPattern = ["p1 p1", ""]
        expect { try self.inputValidator.inputValidation(
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
        expect { try self.inputValidator.inputValidation(
            pattern: badCountPattern)
        }
        .to(throwError(badCountError))
    }

    func testValidPatternShouldReturnMetaData() throws {

        let result = try self.inputValidator.inputValidation(
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
        let result = try self.inputValidator.inputValidation(
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
        let result = try self.inputValidator.inputValidation(
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
