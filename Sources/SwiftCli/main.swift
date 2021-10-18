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

        if (file != nil) {
            let filename = file

            let contents = try! String(contentsOfFile: filename!)

            let subLines = contents.split(separator:"\n")
            let lines = subLines.map { String($0) }
            print(lines)

            chartify.run(userInput: lines)

        }
        else {
            print(pattern)
            chartify.run(userInput: pattern)
        }



    }
}

StartProgram.main()
