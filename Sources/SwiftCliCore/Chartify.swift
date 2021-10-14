import Foundation
import ArgumentParser

public final class Chartify {

    public init(inputValidator: InputValidator, chartConstructor: ChartConstructor) {
        self.inputValidator = inputValidator
        self.chartConstructor = chartConstructor
    }

    var inputValidator: InputValidator
    var chartConstructor: ChartConstructor

    public func run(userInput: [String]) {

        do {
            _ = try userInput.allSatisfy({ try inputValidator.validate(row: $0) })
        } catch {
            print("Unexpected Invalid Input: \(error)")
            print(allowedStitches())
            exit(0)
        }

        do {
            let patternArray = try userInput.map { try inputValidator.arrayMaker(cleanedRow: $0) }
            print(chartConstructor.makeChart(stitchArray: patternArray))
        } catch {
            print(allowedStitches())

        }
    }
}
