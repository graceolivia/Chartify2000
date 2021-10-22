import Foundation
import ArgumentParser

public final class Chartify {

    var inputValidator: InputValidator
    var chartConstructor: ChartConstructor


    public init(inputValidator: InputValidator, chartConstructor: ChartConstructor) {
        self.inputValidator = inputValidator
        self.chartConstructor = chartConstructor
    }

    public func run(userInput: [String], knitFlat: Bool) {

        do {
            let patternMetaData = try inputValidator.inputValidation(pattern: userInput, knitFlat: knitFlat)
            print(chartConstructor.makeChart(patternMetaData: patternMetaData))
        } catch {
            print(error.localizedDescription)
            exit(0)
        }

    }
}
