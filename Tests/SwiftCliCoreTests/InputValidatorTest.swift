import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class ValidatorTests: XCTestCase {
    func testInvalidStitchShouldThrowError() throws {
        expect { try InputValidator().inputValidation(pattern: ["g1 p1"]) }.to(throwError())
    }

    func testEmptyRowShouldThrowError() throws {
        expect { try InputValidator().inputValidation(pattern: ["p1 p1", ""]) }.to(throwError())
    }

    func testInvalidStitchCountShouldThrowError() throws {
        expect { try InputValidator().inputValidation(pattern: ["p1 p1", "p1 p1 p1"]) }.to(throwError())
    }

    func testValidPatternShouldReturnMetaData() throws {
        let result = try InputValidator().inputValidation(pattern: ["p1 p1", "p1 p1"])
        print(result)
        let expectedResult = [
            RowInfo(
                row: ["p1", "p1"],
                rowNumber: 0,
                bottomLine: "└─┴─┘",
                stitchSymbols: "│-│-│\n",
                width: 2,
                leftIncDec: 0,
                rightIncDec: 0,
                leftOffset: 0
            ),
            RowInfo(
                row: ["p1", "p1"],
                rowNumber: 1,
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
}

class KnitFlatTests: XCTestCase {

    func testValidatorForMultiRowInput() throws {
        let result = InputValidator().knitFlatArray(array: [
            ["k1", "p1", "k1", "p1"],
            ["p1", "k1", "p1", "k1"],
            ["k1", "p1", "k1", "p1"],
            ["p1", "k1", "p1", "k1"],
            ["k1", "p1", "k1", "p1"],
            ["p1", "k1", "p1", "k1"]
        ])
        let expectedResult = [
            ["k1", "p1", "k1", "p1"],
            ["k1", "p1", "k1", "p1"],
            ["k1", "p1", "k1", "p1"],
            ["k1", "p1", "k1", "p1"],
            ["k1", "p1", "k1", "p1"],
            ["k1", "p1", "k1", "p1"]
        ]
        expect(result).to(equal(expectedResult))
    }

    func testValidatorForOneRowInput() throws {
        let result = InputValidator().knitFlatArray(array: [["k1", "p1", "k1", "p1"]])
        let expectedResult = [["k1", "p1", "k1", "p1"]]
        expect(result).to(equal(expectedResult))
    }







}
