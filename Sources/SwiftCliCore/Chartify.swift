import Foundation
import ArgumentParser

public final class Chartify {

    var inputValidator: InputValidator
    var chartConstructor: ChartConstructor
    var fileValidator: FileValidator
    var writeToFile: WriteToFile


    public init(inputValidator: InputValidator, chartConstructor: ChartConstructor, fileValidator: FileValidator, writeToFile: WriteToFile) {

        self.inputValidator = inputValidator
        self.chartConstructor = chartConstructor
        self.fileValidator = fileValidator
        self.writeToFile = writeToFile
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
        }
        else { patternToProcess = userInput }

        do {
            let chart = try validateAndChartify(pattern: patternToProcess, knitFlat: knitFlat)

            if let fileNameToWrite = fileNameToWrite {
                do {
                    try writeToFile.writeFile(chart: chart, filePath: "Charts", fileName: fileNameToWrite)
                } catch {
                    print(error.localizedDescription)
                    exit(0)
                }
            } else {
                print(chart) }


        } catch {
            print(error.localizedDescription)
            exit(0)
        }

    }

    private func validateAndChartify(pattern: [String], knitFlat: Bool) throws -> String {
        let metaData = try inputValidator.inputValidation(pattern: pattern, knitFlat: knitFlat)
        return (chartConstructor.makeChart(patternMetaData: metaData))

    }
}
