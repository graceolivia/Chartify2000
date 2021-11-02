import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class ChartifyFinishedTest: XCTestCase {
    func testRunCallsValidator() throws {
        let mock = MockInputValidator()

        Chartify(inputValidator: mock, chartConstructor: ChartConstructor(), fileValidator: FileValidator(), writeToFile: WriteToFile()).run(userInput: ["k1"], knitFlat: false)

        expect(mock.wasValidatorCalled).to(equal(true))
    }
    func testRunCallsMakeChartIfInputIsValid() throws {
        let mock = MockChartConstructor()

        Chartify(inputValidator: InputValidator(), chartConstructor: mock, fileValidator: FileValidator(), writeToFile: WriteToFile()).run(userInput: ["k1"])

        expect(mock.wasMakeChartCalled).to(equal(true))
    }
    func testRunCallsFileValidatorIfFileIsIncluded() throws {
        let mock = MockFileValidator()
        Chartify(inputValidator: InputValidator(), chartConstructor: ChartConstructor(), fileValidator: mock, writeToFile: WriteToFile()).run(userInput: ["k1"], file: Optional("example.txt"))
        expect(mock.wasFileValidatorCalled).to(equal(true))
    }

    func testRunCallsMockWriteToFileIfUserIncludesWriteToFile() throws {
        let mock = MockWriteToFile()
        Chartify(inputValidator: InputValidator(), chartConstructor: ChartConstructor(), fileValidator: FileValidator(), writeToFile: mock).run(userInput: ["k1"], fileNameToWrite: Optional("test"))
        expect(mock.wasWriteToFileCalled).to(equal(true))
    }

    func testRunDoesntCallMockWriteToFileIfUserDoesntIncludeWriteToFile() throws {
        let mock = MockWriteToFile()
        Chartify(inputValidator: InputValidator(), chartConstructor: ChartConstructor(), fileValidator: FileValidator(), writeToFile: mock).run(userInput: ["k1"])
        expect(mock.wasWriteToFileCalled).to(equal(false))
    }

}

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
    override func makeChart(patternMetaData: [RowInfo]) -> String {
        wasMakeChartCalled = true
        return("Done")
    }
}

class MockFileValidator: FileValidator {
    var wasFileValidatorCalled = false
    override func inputValidation(fileLocation: String?) throws -> [String] {
        wasFileValidatorCalled = true
        return ["k1"]
    }
}

class MockWriteToFile: WriteToFile {
    var wasWriteToFileCalled = false

    override func writeFile(chart: String,
                            filePath: String,
                            fileName: String) {

        wasWriteToFileCalled = true

    }
}
