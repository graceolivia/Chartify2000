import Foundation
import ArgumentParser

public final class Chartify {

    var inputValidator: InputValidator
    var chartConstructor: ChartConstructor
    var userInterface: ConsoleUserInterface


    public init(
        inputValidator: InputValidator,
        chartConstructor: ChartConstructor,
        userInterface: ConsoleUserInterface
    ) {
        self.inputValidator = inputValidator
        self.chartConstructor = chartConstructor
        self.userInterface = userInterface
    }

    public func run(userInput: [String], knitFlat: Bool) {

        do {
            let patternMetaData = try inputValidator.inputValidation(pattern: userInput, knitFlat: knitFlat)
            userInterface.showToUser(message: chartConstructor.makeChart(patternMetaData: patternMetaData))
        } catch {
            userInterface.showToUser(message: error.localizedDescription)
            exit(0)
        }

    }
}
