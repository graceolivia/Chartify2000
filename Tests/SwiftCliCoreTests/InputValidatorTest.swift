import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class ValidatorTests: XCTestCase {
    func testInvalidStitchShouldThrowError() throws {
        let testPattern = ["g1 p1"]
        let err = InputError.invalidStitchWithLocation(invalidStitch: "g1", rowLocation: 1)
        expect { try InputValidator().inputValidation(pattern: testPattern, knitFlat: false) }.to(throwError(err))
    }

    func testEmptyRowShouldThrowError() throws {
        let testPattern = ["p1 p1", ""]
        expect { try InputValidator().inputValidation(pattern: testPattern, knitFlat: false) }.to(throwError())
    }

    func testInvalidStitchCountShouldThrowError() throws {
        let testPattern = ["p1 p1", "p1 p1 p1"]
        expect { try InputValidator().inputValidation(pattern: testPattern, knitFlat: false) }.to(throwError())
    }

    func testValidPatternShouldReturnMetaData() throws {
        let result = try InputValidator().inputValidation(pattern: ["p1 p1", "p1 p1"], knitFlat: false)
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

    func testValidPatternKnitFlatShouldReturnMetaData() throws {
        let result = try InputValidator().inputValidation(pattern: ["k1 p1", "p1 k1"], knitFlat: true)
        print(result)
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
}
