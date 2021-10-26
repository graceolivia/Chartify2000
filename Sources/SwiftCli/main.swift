import SwiftCliCore
import ArgumentParser

struct StartProgram: ParsableCommand{

    @Argument(help: "Input the pattern.")
    var pattern: [String] = []

    @Option(help: "File path to a text file")
    var file: String?

    func run() {
        let inputValidator = InputValidator()
        let chartConstructor = ChartConstructor()
        let fileValidator = FileValidator()
        let chartify = Chartify(inputValidator: inputValidator, chartConstructor: chartConstructor, fileValidator: fileValidator)
        chartify.run(userInput: pattern, file: file)

    }
}

StartProgram.main()
