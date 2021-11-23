import Foundation
import ArgumentParser

public final class Chartify {

    var inputValidator: InputValidator
    var chartConstructor: ChartConstructor
    var fileValidator: FileValidator
    var outputWriter: OutputWriter
    var stitchLibrary: StitchLibrary

    public init(
        inputValidator: InputValidator,
        chartConstructor: ChartConstructor,
        fileValidator: FileValidator,
        outputWriter: OutputWriter,
        stitchLibrary: StitchLibrary
    ) {
        self.inputValidator = inputValidator
        self.chartConstructor = chartConstructor
        self.fileValidator = fileValidator
        self.outputWriter = outputWriter
        self.stitchLibrary = stitchLibrary

    }

    public func run(userInput: [String], file: String? = nil, knitFlat: Bool = false) {

        var patternToProcess: [String]
        if let fileString = file {
            do {
                patternToProcess = try fileValidator.inputValidation(fileLocation: fileString)
            } catch {
                print(error.localizedDescription)
                return
            }
        } else { patternToProcess = userInput }

        let patternOrErrors = inputValidator.validateInput(pattern: patternToProcess, knitFlat: knitFlat)
        var errors: [InputError] = []
        for result in patternOrErrors.results {
            switch result {
            case .success:
                continue
            case .failure(let error):
                errors.append(error)
            }
        }

        guard errors.isEmpty else {
            errors.forEach { error in
                print("\(error.localizedDescription)")
            }
            return

        }
        let chart = chartConstructor.makeChart(patternMetaData: patternOrErrors.arrayOfRowInfo)
        do {
            try outputWriter.writeOutput(output: chart)
            return
        } catch {
            print(error.localizedDescription)
            return
        }

    }

}
