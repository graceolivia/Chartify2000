import SwiftCliCore
import ArgumentParser

struct StartProgram: ParsableCommand {

    @Argument(help: "Input the pattern.")
    var pattern: [String] = []

    @Option(help: "File path to a text file")
    var file: String?

    @Flag(help: "Set if you want your pattern to be knit flat. Default value is knit in the round.")
    var knitFlat = false

    @Option(help: "File name to save pattern under.")
    var outputFile: String?

    @Flag(help: "Call this for info about the stitches you are allowed to use.")
    var stitches = false

    func run() {
        let patternNormalizer = PatternNormalizer()
        let nestedArrayBuilder = NestedArrayBuilder()
        let inputValidator = InputValidator(patternNormalizer: patternNormalizer, nestedArrayBuilder: nestedArrayBuilder)
        let chartConstructor = ChartConstructor()
        let fileValidator = FileValidator()
        let fileWriter = FileWriter()
        let instructionsGiver = InstructionsGiver()
      
        let chartify = Chartify(
          inputValidator: inputValidator, 
          chartConstructor: chartConstructor, 
          fileValidator: fileValidator, 
          fileWriter: fileWriter,
          instructionsGiver: instructionsGiver
        )
        chartify.run(
          userInput: pattern, 
          file: file, 
          knitFlat: knitFlat, 
          fileNameToWrite: outputFile)


    }
}

StartProgram.main()
