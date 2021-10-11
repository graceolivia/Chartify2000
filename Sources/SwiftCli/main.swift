import SwiftCliCore
import ArgumentParser


struct StartProgram: ParsableCommand {

    @Argument(help: "Input the pattern.")
    var pattern: String

    func run(){
        let chartify = Chartify()
        chartify.run(userInput: pattern)

    }

}

StartProgram.main()
