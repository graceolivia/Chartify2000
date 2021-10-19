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

        if file != nil {
            guard let filename = file else {
                print("No file was entered.")
                return
            }

            guard filename.suffix(4) == ".txt" else {
                print("Only files with .txt extension are allowed")
                return
            }
            do {
                let contents = try String(contentsOfFile: filename)
                let subLines = contents.split(separator: "\n")
                let lines = subLines.map { String($0) }

                chartify.run(userInput: lines)

            } catch {
                print("Error: Unreadable or nonexistant file.")
            }

        } else {

            chartify.run(userInput: pattern)
        }

    }
}

StartProgram.main()
