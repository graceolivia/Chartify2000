import SwiftCliCore
import ArgumentParser

struct StartProgram: ParsableCommand {

    @Argument(help: "Input the pattern.")
    var pattern: [String] = []

    func run() {
        let inputValidator = InputValidator()
        let chartConstructor = ChartConstructor()
        let chartify = Chartify(inputValidator: inputValidator, chartConstructor: chartConstructor)
        chartify.run(userInput: pattern)
    }
}

StartProgram.main()
