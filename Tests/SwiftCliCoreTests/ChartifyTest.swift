import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class ChartifyFinishedTest: XCTestCase {
    func testRunCallsValidator() throws {
        let mock = MockInputValidator()
        Chartify(inputValidator: mock, chartConstructor: ChartConstructor(), fileValidator: FileValidator()).run(userInput: ["k1"])
        expect(mock.wasValidatorCalled).to(equal(true))
    }

    func testRunCallsMakeChartIfInputIsValid() throws {
        let mock = MockChartConstructor()
        Chartify(inputValidator: InputValidator(), chartConstructor: mock, fileValidator: FileValidator()).run(userInput: ["k1"])
        expect(mock.wasMakeChartCalled).to(equal(true))
    }
    func testRunCallsFileValidatorIfFileIsIncluded() throws {
        let mock = MockFileValidator()
        Chartify(inputValidator: InputValidator(), chartConstructor: ChartConstructor(), fileValidator: mock).run(userInput: ["k1"], file: Optional("example.txt"))
        expect(mock.wasFileValidatorCalled).to(equal(true))
    }

}

class MockInputValidator: InputValidator {
    var wasValidatorCalled = false

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
        )]
    }
}

class MockChartConstructor: ChartConstructor {
    var wasMakeChartCalled = false
    override func makeChart(patternMetaData: [RowInfo]) -> String {
        wasMakeChartCalled = true
        return("Done")
    }
}

class MockFileValidator: FileValidator {
    var wasFileValidatorCalled = false
    override func inputValidation(fileLocation: String?) throws -> [String] {
        print("HAi")
        wasFileValidatorCalled = true
        return ["Done"]
    }
}
