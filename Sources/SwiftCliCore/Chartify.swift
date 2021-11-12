import Foundation
import ArgumentParser

public final class Chartify {

    var inputValidator: InputValidator
    var chartConstructor: ChartConstructor
    var fileValidator: FileValidator
    var outputWriter: OutputWriter

    public init(
        inputValidator: InputValidator,
        chartConstructor: ChartConstructor,
        fileValidator: FileValidator,
        outputWriter: OutputWriter
    ) {
        self.inputValidator = inputValidator
        self.chartConstructor = chartConstructor
        self.fileValidator = fileValidator
        self.outputWriter = outputWriter
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

        do {
            let chart = try validateAndChartify(pattern: patternToProcess, knitFlat: knitFlat)
            try outputWriter.writeOutput(output: chart)
        } catch {
            print(error.localizedDescription)
            return
        }

    }

    private func validateAndChartify(pattern: [String], knitFlat: Bool) throws -> String {
        let metaData = try inputValidator.validateInput(pattern: pattern, knitFlat: knitFlat)
        return (chartConstructor.makeChart(patternMetaData: metaData))

    }

}
