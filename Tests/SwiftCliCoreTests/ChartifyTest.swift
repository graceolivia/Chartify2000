import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class ChartifyFinishedTest: XCTestCase {
    func testRunValidatesTheInput() throws {
        let mock = MockInputValidator()
        Chartify().run(userInput: "k1", inputValidator: mock, chartConstructor: ChartConstructor())
        let result = mock.wasValidateCalled
        let expectedResult = true
    expect(result).to(equal(expectedResult))
}

    func testRunTransformsTheInputIntoAnArrayIfInputIsValid() throws {
        let mock = MockInputValidator()
        Chartify().run(userInput: "k1", inputValidator: mock, chartConstructor: ChartConstructor())
        let result = mock.wasArrayMakerCalled
        let expectedResult = true
        expect(result).to(equal(expectedResult))
    }

    func testRunMakesTheChartIfInputIsValid() throws {
        let mock = MockChartConstructor()
        Chartify().run(userInput: "k1", inputValidator: InputValidator(), chartConstructor: mock)
        let result = mock.wasMakeChartCalled
        let expectedResult = true
        expect(result).to(equal(expectedResult))
    }

}

class MockInputValidator: InputValidator {
    var wasValidateCalled = false
    var wasArrayMakerCalled = false

    override func validate(pattern: String) -> Bool {
        wasValidateCalled = true
        return wasValidateCalled
    }

    override func arrayMaker(cleanedPattern: String) -> [[String]] {
        wasArrayMakerCalled = true
        return [[cleanedPattern]]
    }
}

class MockChartConstructor: ChartConstructor {
    var wasMakeChartCalled = false
    override func makeChart(stitchArray: [[String]]) -> String {
        wasMakeChartCalled = true
        return("Done")
    }
}
