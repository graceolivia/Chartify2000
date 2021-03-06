import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class ChartifyFinishedTest: XCTestCase {
    func testRunCallsValidator() throws {
        let mock = MockInputValidator(patternNormalizer: PatternNormalizer(), nestedArrayBuilder: NestedArrayBuilder())

        Chartify(
            inputValidator: mock,
            chartConstructor: ChartConstructor(),
            fileValidator: FileValidator(),
            outputWriter: ConsoleWriter()
        ).run(userInput: ["k1 k1 k1", "k1 k1 k1"], knitFlat: false)

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
            outputWriter: ConsoleWriter()
        ).run(userInput: ["k1"])

        expect(mock.wasMakeChartCalled).to(equal(true))
    }
    func testRunCallsFileValidatorIfFileIsIncluded() throws {
        let mock = MockFileValidator()

        Chartify(
            inputValidator: InputValidator(patternNormalizer: PatternNormalizer(), nestedArrayBuilder: NestedArrayBuilder()),
            chartConstructor: ChartConstructor(),
            fileValidator: mock,
            outputWriter: ConsoleWriter()
        ).run(userInput: ["k1"], file: "Example.txt")

        expect(mock.wasFileValidatorCalled).to(equal(true))
    }

    func testRunCallsWriteToFileIfUserIncludesWriteToFile() throws {
        let mock = MockOutputWriter()
        Chartify(
            inputValidator: InputValidator(patternNormalizer: PatternNormalizer(), nestedArrayBuilder: NestedArrayBuilder()),
            chartConstructor: ChartConstructor(),
            fileValidator: FileValidator(),
            outputWriter: mock
        ).run(userInput: ["k1"])
        expect(mock.wasWriteOutputCalled).to(equal(true))
    }
}

class MockInputValidator: InputValidator {
    var wasValidatorCalled = false

    override func validateInput(pattern: [String], knitFlat: Bool) -> PatternDataAndPossibleErrors {

        wasValidatorCalled = true
        return PatternDataAndPossibleErrors(
            arrayOfStrings: ["p1 p1"],
            arrayOfArrays: [["p1", "p1"]],
            arrayOfRowInfo: [
                SwiftCliCore.RowInfo(
                    row: ["p1", "p1"],
                    rowIndex: 0,
                    bottomLine: "???????????????",
                    stitchSymbols: "???-???-???\n",
                    width: 2,
                    patternRowsCount: 0,
                    leftIncDec: 0,
                    rightIncDec: 0,
                    leftOffset: 0,
                    transRowLeftOffset: 0)
            ],
            results: [
                Swift.Result<SwiftCliCore.Success, SwiftCliCore.InputError>.success(SwiftCliCore.Success.patternArray(["p1 p1"])),
                Swift.Result<SwiftCliCore.Success, SwiftCliCore.InputError>.success(SwiftCliCore.Success.patternNestedArray([["p1", "p1"]])),
                Swift.Result<SwiftCliCore.Success, SwiftCliCore.InputError>.success(SwiftCliCore.Success.patternNestedArray([["p1", "p1"]])),
                Swift.Result<SwiftCliCore.Success, SwiftCliCore.InputError>.success(SwiftCliCore.Success.patternRowInfo(
                    [
                        SwiftCliCore.RowInfo(
                            row: ["p1", "p1"],
                            rowIndex: 0,
                            bottomLine: "???????????????",
                            stitchSymbols: "???-???-???\n",
                            width: 2,
                            patternRowsCount: 0,
                            leftIncDec: 0,
                            rightIncDec: 0,
                            leftOffset: 0,
                            transRowLeftOffset: 0)
                    ]
                ))
            ]
        )
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
        wasFileValidatorCalled = true
        return ["k1"]
    }
}

class MockOutputWriter: OutputWriter {
    var wasWriteOutputCalled = false

    func writeOutput(output: String) throws {

        wasWriteOutputCalled = true

    }
}
