import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class ValidatorTests: XCTestCase {

    private var inputValidator: InputValidator!

    override func setUp() {
        super.setUp()
        inputValidator = InputValidator(
            patternNormalizer: PatternNormalizer(),
            nestedArrayBuilder: NestedArrayBuilder(stitchLibrary: StitchLibrary()),
            stitchLibrary: StitchLibrary(),
            metaDataBuilder: MetaDataBuilder(
                chartConstructor: ChartConstructor(
                    stitchLibrary: StitchLibrary()),
                stitchLibrary: StitchLibrary()
            )
        )
    }

    func testEmptyRowShouldThrowError() throws {
        let testPattern = ["p1 p1", ""]
        let result = self.inputValidator.validateInput(
            pattern: testPattern,
            knitFlat: false
        )
        let expectedResult = PatternDataAndPossibleErrors(
            arrayOfStrings: ["p1 p1", ""],
            arrayOfArrays: [["p1", "p1"], []],
            arrayOfRowInfo: [],
            results: [
                Result.failure(InputError.emptyRow(row: 2)),
                Result<Success, InputError>.success(Success.patternNestedArray([["p1", "p1"], []])),
               .success(Success.patternNestedArray([["p1", "p1"], []]))
            ]
        )
        expect(result).to(equal(expectedResult))
    }

    func testInvalidStitchShouldThrowError() throws {
        let testPattern = ["g1 p1"]
        let result = self.inputValidator.validateInput(
            pattern: testPattern,
            knitFlat: false
        )
        let expectedResult = PatternDataAndPossibleErrors(
            arrayOfStrings: ["g1 p1"],
            arrayOfArrays: [["g1", "p1"]],
            arrayOfRowInfo: [],
            results: [
               .success(Success.patternArray(["g1 p1"])),
               .failure(InputError.multipleErrors(errors: [
                    InputError.invalidStitch(invalidStitch: "g1", rowLocation: 1, stitchIndexInRow: 1)
                ])),
               .success(Success.patternNestedArray([["g1", "p1"]]))])
        expect(result).to(equal(expectedResult))

    }


    func testInvalidStitchCountShouldThrowError() throws {
        let badCountPattern = ["p1 p1", "p1 p1 p1"]
        let result = self.inputValidator.validateInput(
            pattern: badCountPattern,
            knitFlat: false
        )
        let expectedResult = PatternDataAndPossibleErrors(
            arrayOfStrings: ["p1 p1", "p1 p1 p1"],
            arrayOfArrays: [["p1", "p1"], ["p1", "p1", "p1"]],
            arrayOfRowInfo: [
                RowInfo(
                    row: ["p1", "p1"],
                    rowIndex: 0,
                    bottomLine: "└─┴─┘",
                    stitchSymbols: "│-│-│\n",
                    width: 2,
                    patternRowsCount: 0,
                    leftIncDec: 0,
                    rightIncDec: 0,
                    leftOffset: 0,
                    transRowLeftOffset: 0
                ),
                RowInfo(
                    row: ["p1", "p1", "p1"],
                    rowIndex: 1,
                    bottomLine: "├─┼─┼─┤\n",
                    stitchSymbols: "│-│-│-│\n",
                    width: 3,
                    patternRowsCount: 0,
                    leftIncDec: 0,
                    rightIncDec: 0,
                    leftOffset: 0,
                    transRowLeftOffset: 0
                )
            ],
            results: [
               .success(Success.patternArray(["p1 p1", "p1 p1 p1"])),
               .success(Success.patternNestedArray([["p1", "p1"], ["p1", "p1", "p1"]])),
               .success(Success.patternNestedArray([["p1", "p1"], ["p1", "p1", "p1"]])),
               .failure(InputError.invalidRowWidth(invalidRowNumber: 2, expectedStitchCount: 2, actualCount: 3))
            ]
        )
        expect(result).to(equal(expectedResult))

    }

    func testMultipleIncorrectStitchesTypesAndEmptyRowShouldThrowMultipleErrors() throws {
        let multipleIncorrectStitchesPattern = ["", "g1 p1", "p1 g1"]
        let result = self.inputValidator.validateInput(
            pattern: multipleIncorrectStitchesPattern,
            knitFlat: false
        )
        let expectedResult = PatternDataAndPossibleErrors(
            arrayOfStrings: ["", "g1 p1", "p1 g1"],
            arrayOfArrays: [[], ["g1", "p1"], ["p1", "g1"]],
            arrayOfRowInfo: [],
            results: [
               .failure(InputError.emptyRow(row: 1)),
               .failure(
                    InputError.multipleErrors(
                        errors: [
                            InputError.invalidStitch(invalidStitch: "g1", rowLocation: 2, stitchIndexInRow: 1),
                            InputError.invalidStitch(invalidStitch: "g1", rowLocation: 3, stitchIndexInRow: 2)
                        ]
                    )
                ),
               .success(Success.patternNestedArray([[], ["g1", "p1"], ["p1", "g1"]]))])
        expect(result).to(equal(expectedResult))
    }


    func testZeroCountStitchShouldThrowOneError() throws {
        let zeroCountStitchesPattern = ["k0 p1"]
        let result = self.inputValidator.validateInput(
            pattern: zeroCountStitchesPattern,
            knitFlat: false
        )
        let expectedResult = PatternDataAndPossibleErrors(
            arrayOfStrings: ["k0 p1"],
            arrayOfArrays: [["k0", "p1"]],
            arrayOfRowInfo: [],
            results: [
               .success(Success.patternArray(["k0 p1"])),
               .failure(InputError.multipleErrors(
                    errors: [
                        InputError.invalidStitchNumber(
                            rowNumber: 1,
                            invalidStitch: "k0",
                            validStitchType: "k",
                            invalidStitchNumber: "0",
                            stitchIndexInRow: 1
                        )
                    ]
                )),
               .success(Success.patternNestedArray([["k0", "p1"]]))
            ]
        )
        expect(result).to(equal(expectedResult))
    }

    func testValidPatternShouldReturnAllSuccesses() throws {


        let result = self.inputValidator.validateInput(
            pattern: ["p1 p1", "p1 p1"],
            knitFlat: false
        )
        let expectedResult = PatternDataAndPossibleErrors(
            arrayOfStrings: ["p1 p1", "p1 p1"],
            arrayOfArrays: [["p1", "p1"], ["p1", "p1"]],
            arrayOfRowInfo: [
                RowInfo(
                    row: ["p1", "p1"],
                    rowIndex: 0,
                    bottomLine: "└─┴─┘",
                    stitchSymbols: "│-│-│\n",
                    width: 2,
                    patternRowsCount: 0,
                    leftIncDec: 0,
                    rightIncDec: 0,
                    leftOffset: 0,
                    transRowLeftOffset: 0
),
                RowInfo(
                    row: ["p1", "p1"],
                    rowIndex: 1,
                    bottomLine: "├─┼─┤\n",
                    stitchSymbols: "│-│-│\n",
                    width: 2,
                    patternRowsCount: 0,
                    leftIncDec: 0,
                    rightIncDec: 0,
                    leftOffset: 0,
                    transRowLeftOffset: 0
                )
            ],
            results: [
               .success(Success.patternArray(["p1 p1", "p1 p1"])),
               .success(Success.patternNestedArray([["p1", "p1"], ["p1", "p1"]])),
               .success(Success.patternNestedArray([["p1", "p1"], ["p1", "p1"]])),
               .success(Success.patternRowInfo([
                    RowInfo(
                        row: ["p1", "p1"],
                        rowIndex: 0,
                        bottomLine: "└─┴─┘",
                        stitchSymbols: "│-│-│\n",
                        width: 2,
                        patternRowsCount: 0,
                        leftIncDec: 0,
                        rightIncDec: 0,
                        leftOffset: 0,
                        transRowLeftOffset: 0
                    ),
                    RowInfo(
                        row: ["p1", "p1"],
                        rowIndex: 1,
                        bottomLine: "├─┼─┤\n",
                        stitchSymbols: "│-│-│\n",
                        width: 2,
                        patternRowsCount: 0,
                        leftIncDec: 0,
                        rightIncDec: 0,
                        leftOffset: 0,
                        transRowLeftOffset: 0
                    )
                ]))])
        expect(result).to(equal(expectedResult))
    }

    func testValidPatternKnitFlatShouldReturnMetaData() throws {

        let result = self.inputValidator.validateInput(
            pattern: ["k1 p1", "p1 k1"],
            knitFlat: true
        )
        let expectedResult = PatternDataAndPossibleErrors(
            arrayOfStrings: ["k1 p1", "p1 k1"],
            arrayOfArrays: [["k1", "p1"], ["k1", "p1"]],
            arrayOfRowInfo: [
                RowInfo(
                    row: ["k1", "p1"],
                    rowIndex: 0,
                    bottomLine: "└─┴─┘",
                    stitchSymbols: "│ │-│\n",
                    width: 2,
                    patternRowsCount: 0,
                    leftIncDec: 0,
                    rightIncDec: 0,
                    leftOffset: 0,
                    transRowLeftOffset: 0
                ),
                RowInfo(
                    row: ["k1", "p1"],
                    rowIndex: 1,
                    bottomLine: "├─┼─┤\n",
                    stitchSymbols: "│ │-│\n",
                    width: 2,
                    patternRowsCount: 0,
                    leftIncDec: 0,
                    rightIncDec: 0,
                    leftOffset: 0,
                    transRowLeftOffset: 0
                )
            ],
            results: [
               .success(Success.patternArray(["k1 p1", "p1 k1"])),
               .success(Success.patternNestedArray([["k1", "p1"], ["k1", "p1"]])),
               .success(Success.patternNestedArray([["k1", "p1"], ["k1", "p1"]])),
               .success(Success.patternRowInfo(
                    [
                RowInfo(
                    row: ["k1", "p1"],
                    rowIndex: 0,
                    bottomLine: "└─┴─┘",
                    stitchSymbols: "│ │-│\n",
                    width: 2,
                    patternRowsCount: 0,
                    leftIncDec: 0,
                    rightIncDec: 0,
                    leftOffset: 0,
                    transRowLeftOffset: 0
                ),
                RowInfo(
                    row: ["k1", "p1"],
                    rowIndex: 1,
                    bottomLine: "├─┼─┤\n",
                    stitchSymbols: "│ │-│\n",
                    width: 2,
                    patternRowsCount: 0,
                    leftIncDec: 0,
                    rightIncDec: 0,
                    leftOffset: 0,
                    transRowLeftOffset: 0
                )
            ]
                )
                                                                                   )
            ]
        )
        expect(result).to(equal(expectedResult))
    }

    func testValidPatternWithUpperCaseShouldReturnMetaData() throws {
        let result = self.inputValidator.validateInput(
            pattern: ["K1 P1", "P1 K1"]
        )
        let expectedResult = PatternDataAndPossibleErrors(
            arrayOfStrings: ["k1 p1", "p1 k1"],
            arrayOfArrays: [["k1", "p1"], ["p1", "k1"]],
            arrayOfRowInfo: [
                RowInfo(
                    row: ["k1", "p1"],
                    rowIndex: 0,
                    bottomLine: "└─┴─┘",
                    stitchSymbols: "│ │-│\n",
                    width: 2,
                    patternRowsCount: 0,
                    leftIncDec: 0,
                    rightIncDec: 0,
                    leftOffset: 0,
                    transRowLeftOffset: 0),
                RowInfo(
                    row: ["p1", "k1"],
                    rowIndex: 1,
                    bottomLine: "├─┼─┤\n",
                    stitchSymbols: "│-│ │\n",
                    width: 2,
                    patternRowsCount: 0,
                    leftIncDec: 0,
                    rightIncDec: 0,
                    leftOffset: 0,
                    transRowLeftOffset: 0)],
            results: [
               .success(Success.patternArray(["k1 p1", "p1 k1"])),
               .success(Success.patternNestedArray([["k1", "p1"], ["p1", "k1"]])),
               .success(Success.patternNestedArray([["k1", "p1"], ["p1", "k1"]])),
               .success(Success.patternRowInfo(
                    [
                        RowInfo(
                            row: ["k1", "p1"],
                            rowIndex: 0,
                            bottomLine: "└─┴─┘",
                            stitchSymbols: "│ │-│\n",
                            width: 2,
                            patternRowsCount: 0,
                            leftIncDec: 0,
                            rightIncDec: 0,
                            leftOffset: 0,
                            transRowLeftOffset: 0
                        ),
                        RowInfo(
                            row: ["p1", "k1"],
                            rowIndex: 1,
                            bottomLine: "├─┼─┤\n",
                            stitchSymbols: "│-│ │\n",
                            width: 2,
                            patternRowsCount: 0,
                            leftIncDec: 0,
                            rightIncDec: 0,
                            leftOffset: 0,
                            transRowLeftOffset: 0
                        )
                    ]))])
        expect(result).to(equal(expectedResult))
    }
}
