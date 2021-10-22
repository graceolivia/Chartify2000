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

    public func run(userInput: [String], file: String? = nil) {
        if file != nil {
            do {
                let readInFile = try fileValidator.inputValidation(fileLocation: file!)
                let metaData = try inputValidator.inputValidation(pattern: readInFile)
                print(chartConstructor.makeChart(patternMetaData: metaData))
            } catch {
                print(error.localizedDescription)
            }
        }
        else {
            do {
                let metaData = try inputValidator.inputValidation(pattern: userInput)
                print(chartConstructor.makeChart(patternMetaData: metaData))
            } catch {
                print(error.localizedDescription)
                exit(0)
            }
        }
    }
}
