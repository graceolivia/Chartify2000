import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class ChartifyFinishedTest: XCTestCase {
    func testRunCallsValidator() throws {
        let mock = MockInputValidator(patternNormalizer: PatternNormalizer(), nestedArrayBuilder: NestedArrayBuilder())

        Chartify(inputValidator: mock, chartConstructor: ChartConstructor(), fileValidator: FileValidator(), fileWriter: FileWriter(), instructionsGiver: InstructionsGiver()).run(userInput: ["k1"], knitFlat: false)

        expect(mock.wasValidatorCalled).to(equal(true))
    }
    func testRunCallsMakeChartIfInputIsValid() throws {
        let mock = MockChartConstructor()

        Chartify(
            inputValidator: InputValidator(
                patternNormalizer: PatternNormalizer(),
                nestedArrayBuilder: NestedArrayBuilder()
            ),
            chartConstructor: mock,
            fileValidator: FileValidator(),
            fileWriter: FileWriter(), instructionsGiver: InstructionsGiver()).run(userInput: ["k1"])

        expect(mock.wasMakeChartCalled).to(equal(true))
    }
    func testRunCallsFileValidatorIfFileIsIncluded() throws {
        let mock = MockFileValidator()

        Chartify(inputValidator: InputValidator(patternNormalizer: PatternNormalizer(), nestedArrayBuilder: NestedArrayBuilder()), chartConstructor: ChartConstructor(), fileValidator: mock, fileWriter: FileWriter(), instructionsGiver: InstructionsGiver()).run(userInput: ["k1"], file: Optional("example.txt"))

        expect(mock.wasFileValidatorCalled).to(equal(true))
    }

    func testRunCallsWriteToFileIfUserIncludesWriteToFile() throws {
        let mock = MockFileWriter()
        Chartify(inputValidator: InputValidator(patternNormalizer: PatternNormalizer(), nestedArrayBuilder: NestedArrayBuilder()), chartConstructor: ChartConstructor(), fileValidator: FileValidator(), fileWriter: mock, instructionsGiver: InstructionsGiver()).run(userInput: ["k1"], fileNameToWrite: Optional("test"))
        expect(mock.wasWriteFileCalled).to(equal(true))
    }

    func testCallInstructionsGiver() throws {
        let mock = MockInstructionsGiver()
        Chartify(inputValidator: InputValidator(patternNormalizer: PatternNormalizer(), nestedArrayBuilder: NestedArrayBuilder()), chartConstructor: ChartConstructor(), fileValidator: FileValidator(), fileWriter: FileWriter(), instructionsGiver: mock).run(userInput: ["k1"], stitches: true)
        expect(mock.wasGiveInstructionsCalled).to(equal(true))
    }

}

class MockInputValidator: InputValidator {
    var wasValidatorCalled = false

    override func validateInput(pattern: [String], knitFlat: Bool) throws -> [RowInfo] {

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

class MockFileWriter: FileWriter {
    var wasWriteFileCalled = false

    override func writeFile(chart: String,
                            filePath: String,
                            fileName: String) {

        wasWriteFileCalled = true

    }
}

class MockInstructionsGiver: InstructionsGiver {
    var wasGiveInstructionsCalled = false

    override func giveInstructions() -> String {
        wasGiveInstructionsCalled = true
        return("Done")
    }
}
