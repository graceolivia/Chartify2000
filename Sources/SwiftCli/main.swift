import SwiftCliCore
import ArgumentParser

struct StartProgram: ParsableCommand {

    @Argument(help: "Input the pattern.")
    var pattern: [String] = []

    @Option(help: "File path to a text file")
    var file: String?

    @Flag(help: "Set if you want your pattern to be knit flat. Default value is knit in the round.")
    var knitFlat = false

    @Option(help: "File name to save pattern under. Pick a file directory or the file will be placed in the directory of this application by default.")
    var outputFile: String?

    @Flag(help: "Call this for info about the stitches you are allowed to use.")
    var stitches = false

    func run() {   
        let patternNormalizer = PatternNormalizer()
        let stitchLibrary = StitchLibrary()
        let chartConstructor = ChartConstructor(stitchLibrary: stitchLibrary)
        let nestedArrayBuilder = NestedArrayBuilder(stitchLibrary: stitchLibrary)
        let metaDataBuilder = MetaDataBuilder(
            chartConstructor: chartConstructor,
            stitchLibrary: stitchLibrary
        )
        let inputValidator = InputValidator(
            patternNormalizer: patternNormalizer,
            nestedArrayBuilder: nestedArrayBuilder,
            stitchLibrary: stitchLibrary,
            metaDataBuilder: metaDataBuilder
        )

        let fileValidator = FileValidator()

        let outputWriter: OutputWriter
        if let outputFile = outputFile {
            outputWriter = FileWriter(filePath: outputFile)
        } else {
            outputWriter = ConsoleWriter()
        }
        let instructionsGiver = InstructionsGiver(
            consoleWriter: ConsoleWriter(),
            fileValidator: fileValidator,
            stitchLibrary: stitchLibrary
        )


        if stitches {
            do {
                try instructionsGiver.giveInstructions()
            } catch {
                print(error.localizedDescription)
            }
        } else {

            let chartify = Chartify(
                inputValidator: inputValidator,
                chartConstructor: chartConstructor,
                fileValidator: fileValidator,
                outputWriter: outputWriter,
                stitchLibrary: stitchLibrary
            )
            chartify.run(
                userInput: pattern,
                file: file,
                knitFlat: knitFlat
            )
        }

    }
}

StartProgram.main()
