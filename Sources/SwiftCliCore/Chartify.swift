import Foundation
import ArgumentParser

public final class Chartify {

    var inputValidator: InputValidator
    var chartConstructor: ChartConstructor
    var fileValidator: FileValidator
    var fileWriter: FileWriter

    public init(inputValidator: InputValidator, chartConstructor: ChartConstructor, fileValidator: FileValidator, fileWriter: FileWriter) {
        self.inputValidator = inputValidator
        self.chartConstructor = chartConstructor
        self.fileValidator = fileValidator
        self.fileWriter = fileWriter
    }

    public func run(userInput: [String], file: String? = nil, knitFlat: Bool = false, fileNameToWrite: String? = nil) {

        var patternToProcess: [String]
        if let fileString = file {
            do {
                patternToProcess = try fileValidator.inputValidation(fileLocation: fileString)
            } catch {
                print(error.localizedDescription)
                exit(0)
            }
        } else { patternToProcess = userInput }

        do {
            let chart = try validateAndChartify(pattern: patternToProcess, knitFlat: knitFlat)

            try returnChartInPreferredFormat(chart: chart, fileNameToWrite: fileNameToWrite)

        } catch {
            print(error.localizedDescription)
            exit(0)
        }

    }

    private func validateAndChartify(pattern: [String], knitFlat: Bool) throws -> String {
        let metaData = try inputValidator.validateInput(pattern: pattern, knitFlat: knitFlat)
        return (chartConstructor.makeChart(patternMetaData: metaData))

    }

    private func returnChartInPreferredFormat(chart: String, fileNameToWrite: String?) throws {
        if let fileNameToWrite = fileNameToWrite {
            do {
                try fileWriter.writeFile(chart: chart, filePath: "Charts", fileName: fileNameToWrite)
            } catch {
                throw error
            }
        } else {
            print(chart) }
    }

}


