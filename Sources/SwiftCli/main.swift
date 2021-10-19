import SwiftCliCore
import ArgumentParser

struct StartProgram: ParsableCommand {

    @Argument(help: "Input the pattern.")
    var pattern: [String] = []

    @Flag(help: "Set if you want your pattern to be knit flat. Default value is knit in the round.")
    var knitFlat = false


    func run() {
        let inputValidator = InputValidator()
        let chartConstructor = ChartConstructor()
        let chartify = Chartify(inputValidator: inputValidator, chartConstructor: chartConstructor)
        chartify.run(userInput: pattern, knitFlat: knitFlat)
    }
}

StartProgram.main()
