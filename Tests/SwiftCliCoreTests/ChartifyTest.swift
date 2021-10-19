import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class ChartifyFinishedTest: XCTestCase {
    func testRunCallsValidator() throws {
        let mock = MockInputValidator()
        Chartify(inputValidator: mock, chartConstructor: ChartConstructor()).run(userInput: ["k1"])
        expect(mock.wasValidatorCalled).to(equal(true))
    }

    func testRunCallsKnitFlatArrayIfKnitFlatIsTrue() throws {
        let mock = MockInputValidator()
        Chartify(inputValidator: mock, chartConstructor: ChartConstructor()).run(userInput: ["k1"], knitFlat: true)
        let result = mock.wasKnitFlatArrayCalled
        let expectedResult = true
        expect(result).to(equal(expectedResult))

    }

    func testRunCallsMakeChartIfInputIsValid() throws {
        let mock = MockChartConstructor()
        Chartify(inputValidator: InputValidator(), chartConstructor: mock).run(userInput: ["k1"], knitFlat: false)
        expect(mock.wasMakeChartCalled).to(equal(true))
    }
}

class MockInputValidator: InputValidator {
    var wasValidatorCalled = false
    var wasKnitFlatArrayCalled = false
    override func inputValidation(pattern: [String]) throws -> [RowInfo] {
        wasValidatorCalled = true
        return [RowInfo(
            row: ["p1", "p1"],
            rowNumber: 0,
            bottomLine: "└─┴─┘",
            stitchSymbols: "│-│-│\n",
            width: 2,
            leftIncDec: 0,
            rightIncDec: 0,
            leftOffset: 0
        )]}

        override func knitFlatArray(array: [[String]]) -> [[String]] {
            wasKnitFlatArrayCalled = true
            return array
        }
    }


class MockChartConstructor: ChartConstructor {
    var wasMakeChartCalled = false
    override func makeChart(patternMetaData: [RowInfo]) -> String {
        wasMakeChartCalled = true
        return("Done")
    }
}
