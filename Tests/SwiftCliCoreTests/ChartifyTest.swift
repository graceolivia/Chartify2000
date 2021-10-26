import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class ChartifyFinishedTest: XCTestCase {
    
    func testRunValidatesUserInput() throws {
        let mock = MockInputValidator()
        
        Chartify(inputValidator: mock, chartConstructor: ChartConstructor()).run(userInput: ["k1"], knitFlat: false)
        
        expect(mock.wasValidatorCalled).to(equal(true))
    }
    
    func testRunMakesChartIfInputIsValid() throws {
        let mock = MockChartConstructor()
        
        Chartify(inputValidator: InputValidator(), chartConstructor: mock).run(userInput: ["k1"], knitFlat: false)
        
        expect(mock.wasMakeChartCalled).to(equal(true))
    }
    
    func testRunShowsTheChartToUserIfIntputIsValid() throws {
        let expectedMessage = "Chart"
        let chartConstructor = MockChartConstructor()
        chartContructor.setMakeChartReturnValue(message: expectedMessage)
        let mockUserInterface = MockUserInterface()
        
        Chartify(inputValidator: InputValidator(), chartConstructor:   chartConstructor,
            userInterface: mockUserInterface
        ).run(userInput: ["k1"], knitFlat: false)
        
        expect(mockUserInterface.messagesSentToUser.first).to(equal(expectedMessage))
    }
    
}

// TODO break each mock out into its own file (in  mock subfolder preferably)
class MockInputValidator: InputValidator {
    var wasValidatorCalled = false

    override func inputValidation(pattern: [String], knitFlat: Bool) throws -> [RowInfo] {
        wasValidatorCalled = true
        return [RowInfo(
            row: ["p1", "p1"],
            rowIndex: 0,
            bottomLine: "└─┴─┘",
            stitchSymbols: "│-│-│\n",
            width: 2,
            leftIncDec: 0,
            rightIncDec: 0,
            leftOffset: 0
        )]}
}

class MockChartConstructor: ChartConstructor {
    var wasMakeChartCalled = false
    var makeChartReturnValue = "Done"
    
    override func makeChart(patternMetaData: [RowInfo]) -> String {
        wasMakeChartCalled = true
        return(makeChartReturnValue)
    }
    
    public func setMakeChartReturnValue(message: String) {
        makeChartReturnValue = message
    }
}

class MockUserInterface: ConsoleUserInterface {
    var messagesSentToUser: [String] = []
    
    override func showToUser(message: String) {
        messagesSentToUser.append(message)
    }
}
