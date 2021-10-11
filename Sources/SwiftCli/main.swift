import SwiftCliCore
import ArgumentParser

struct StartProgram: ParsableCommand {

    @Argument(help: "Input the pattern.")
    var pattern: String

    func run() {
        let chartify = Chartify()
        let inputValidator = InputValidator()
        let chartConstructor = ChartConstructor()
        chartify.run(userInput: pattern, inputValidator: inputValidator, chartConstructor: chartConstructor)

    }

}

StartProgram.main()
