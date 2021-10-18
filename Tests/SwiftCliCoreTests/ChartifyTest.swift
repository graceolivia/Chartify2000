import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class ChartifyFinishedTest: XCTestCase {
    func testRunCallsValidate() throws {
        let mock = MockInputValidator()
        Chartify(inputValidator: mock, chartConstructor: ChartConstructor()).run(userInput: ["k1"])
        let result = mock.wasValidateCalled
        let expectedResult = true
        expect(result).to(equal(expectedResult))
    }

    func testRunCallsArrayMakerIfInputIsValid() throws {
        let mock = MockInputValidator()
        Chartify(inputValidator: mock, chartConstructor: ChartConstructor()).run(userInput: ["k1"])
        let result = mock.wasArrayMakerCalled
        let expectedResult = true
        expect(result).to(equal(expectedResult))
    }

    func testRunCallsMakeChartIfInputIsValid() throws {
        let mock = MockChartConstructor()
        Chartify(inputValidator: InputValidator(), chartConstructor: mock).run(userInput: ["k1"])
        let result = mock.wasMakeChartCalled
        let expectedResult = true
        expect(result).to(equal(expectedResult))
    }

}

class MockInputValidator: InputValidator {
    var wasValidateCalled = false
    var wasArrayMakerCalled = false

    override func validateEachStitch(row: String) -> Bool {
        wasValidateCalled = true
        return wasValidateCalled
    }

    override func arrayMaker(cleanedRow: String) -> [String] {
        wasArrayMakerCalled = true
        return [cleanedRow]
    }
}

class MockChartConstructor: ChartConstructor {
    var wasMakeChartCalled = false
    override func makeChart(stitchArray: [[String]]) -> String {
        wasMakeChartCalled = true
        return("Done")
    }
}
