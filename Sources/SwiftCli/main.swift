import SwiftCliCore
import ArgumentParser

struct StartProgram: ParsableCommand {

    @Argument(help: "Input the pattern.")
    var pattern: [String] = []

    @Option(help: "File path")
    var file: String?

    func run() {
        let inputValidator = InputValidator()
        let chartConstructor = ChartConstructor()
        let chartify = Chartify(inputValidator: inputValidator, chartConstructor: chartConstructor)

        if (file) != nil {
            do {
                let readInPattern = try FileValidator().inputValidation(fileLocation: file!)
                chartify.run(userInput: readInPattern)
            } catch {
                print(error.localizedDescription)

            }

        } else {
            chartify.run(userInput: pattern)
        }
    }
}

StartProgram.main()
