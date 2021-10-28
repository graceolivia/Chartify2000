import Foundation
import ArgumentParser

public final class Chartify {

    var inputValidator: InputValidator
    var chartConstructor: ChartConstructor
    var fileValidator: FileValidator


    public init(inputValidator: InputValidator, chartConstructor: ChartConstructor, fileValidator: FileValidator) {

        self.inputValidator = inputValidator
        self.chartConstructor = chartConstructor
        self.fileValidator = fileValidator
    }


    public func run(userInput: [String], file: String? = nil, knitFlat: false) {
        var patternToProcess: [String]
        if let fileString = file {
            do {
                patternToProcess = try fileValidator.inputValidation(fileLocation: fileString)
            } catch {
                print(error.localizedDescription)
                exit(0)
            }
        }
        else { patternToProcess = userInput }

        do {
            let chart = try validateAndChartify(pattern: patternToProcess)
            print(chart)

        } catch {
            print(error.localizedDescription)
            exit(0)
        }

    }

    private func validateAndChartify(pattern: [String]) throws -> String {
        let metaData = try inputValidator.inputValidation(pattern: pattern)
        return (chartConstructor.makeChart(patternMetaData: metaData))

    }
}
