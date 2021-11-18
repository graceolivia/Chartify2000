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

    func testEmptyRowShouldThrowError() throws {
        let testPattern = ["p1 p1", ""]
        let result = self.inputValidator.validateInput(
            pattern: testPattern,
            knitFlat: false
        )
        let expectedResult = PatternDataAndPossibleErrors(
            arrayOfStrings: ["todo"],
            results: [
            .failure(InputError.emptyRow()),
            .success(Success.patternNestedArray([[],["p1", "p1"]])),
            .success(Success.patternNestedArray([[],["p1", "p1"]])),
            .success(Success.patternNestedArray([[],["p1", "p1"]]))
        ])
        expect(result).to(equal(expectedResult))
    }

    func testInvalidStitchShouldThrowError() throws {
        let testPattern = ["g1 p1"]
        let result = self.inputValidator.validateInput(
            pattern: testPattern,
            knitFlat: false
        )
        let expectedResult = PatternDataAndPossibleErrors(arrayOfStrings: ["todo"])
        expect(result).to(equal(expectedResult))

    }


    func testInvalidStitchCountShouldThrowError() throws {
        let badCountPattern = ["p1 p1", "p1 p1", "p1 p1", "p1 p1 p1"]
        let result = self.inputValidator.validateInput(
            pattern: badCountPattern,
            knitFlat: false
        )
        let expectedResult = PatternDataAndPossibleErrors(arrayOfStrings: ["todo"])
        expect(result).to(equal(expectedResult))

    }

    func testMultipleIncorrectStitchesTypesShouldThrowMultipleErrors() throws {
        let multipleIncorrectStitchesPattern = ["p1 p1", "g1 p1", "p1 g1", "g1 p1"]
        let result = self.inputValidator.validateInput(
            pattern: multipleIncorrectStitchesPattern,
            knitFlat: false
        )
        let expectedResult = PatternDataAndPossibleErrors(arrayOfStrings: ["todo"])
        expect(result).to(equal(expectedResult))
    }


    func testZeroCountStitchShouldThrowMultipleErrors() throws {
        let zeroCountStitchesPattern = ["k0 p1"]
        let result = self.inputValidator.validateInput(
            pattern: zeroCountStitchesPattern,
            knitFlat: false
        )
        let expectedResult = PatternDataAndPossibleErrors(arrayOfStrings: ["todo"])
        expect(result).to(equal(expectedResult))
    }

    func testValidPatternShouldReturnMetaData() throws {


        let result = try self.inputValidator.validateInput(
            pattern: ["p1 p1", "p1 p1"],
            knitFlat: false
        )
        let expectedResult = PatternDataAndPossibleErrors(arrayOfStrings: ["todo"])
//        let expectedResult = [
//            RowInfo(
//                row: ["p1", "p1"],
//                rowIndex: 0,
//                bottomLine: "└─┴─┘",
//                stitchSymbols: "│-│-│\n",
//                width: 2,
//                leftIncDec: 0,
//                rightIncDec: 0,
//                leftOffset: 0
//            ),
//            RowInfo(
//                row: ["p1", "p1"],
//                rowIndex: 1,
//                bottomLine: "├─┼─┤\n",
//                stitchSymbols: "│-│-│\n",
//                width: 2,
//                leftIncDec: 0,
//                rightIncDec: 0,
//                leftOffset: 0
//            )
//        ]
        expect(result).to(equal(expectedResult))
    }

    func testValidPatternKnitFlatShouldReturnMetaData() throws {

        let result = try self.inputValidator.validateInput(
            pattern: ["k1 p1", "p1 k1"],
            knitFlat: true
        )
        let expectedResult = PatternDataAndPossibleErrors(arrayOfStrings: ["todo"])

//        let expectedResult = [
//            RowInfo(
//                row: ["k1", "p1"],
//                rowIndex: 0,
//                bottomLine: "└─┴─┘",
//                stitchSymbols: "│ │-│\n",
//                width: 2,
//                leftIncDec: 0,
//                rightIncDec: 0,
//                leftOffset: 0
//            ),
//            RowInfo(
//                row: ["k1", "p1"],
//                rowIndex: 1,
//                bottomLine: "├─┼─┤\n",
//                stitchSymbols: "│ │-│\n",
//                width: 2,
//                leftIncDec: 0,
//                rightIncDec: 0,
//                leftOffset: 0
//            )
//        ]
        expect(result).to(equal(expectedResult))
    }

    func testValidPatternWithUpperCaseShouldReturnMetaData() throws {
        let result = try self.inputValidator.validateInput(
            pattern: ["K1 P1", "P1 K1"]
        )
        let expectedResult = PatternDataAndPossibleErrors(arrayOfStrings: ["todo"])
//        let expectedResult = [
//            RowInfo(
//                row: ["k1", "p1"],
//                rowIndex: 0,
//                bottomLine: "└─┴─┘",
//                stitchSymbols: "│ │-│\n",
//                width: 2,
//                leftIncDec: 0,
//                rightIncDec: 0,
//                leftOffset: 0
//            ),
//            RowInfo(
//                row: ["p1", "k1"],
//                rowIndex: 1,
//                bottomLine: "├─┼─┤\n",
//                stitchSymbols: "│-│ │\n",
//                width: 2,
//                leftIncDec: 0,
//                rightIncDec: 0,
//                leftOffset: 0
//            )
//        ]
        expect(result).to(equal(expectedResult))
    }
}
