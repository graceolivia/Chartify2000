import Foundation
import ArgumentParser

public final class Chartify {

    var inputValidator: InputValidator
    var chartConstructor: ChartConstructor
    var fileValidator: FileValidator
    var patternNormalizer: PatternNormalizer
    var nestedArrayBuilder: NestedArrayBuilder

    public init(inputValidator: InputValidator, chartConstructor: ChartConstructor, fileValidator: FileValidator, patternNormalizer: PatternNormalizer, nestedArrayBuilder: NestedArrayBuilder) {

        self.inputValidator = inputValidator
        self.chartConstructor = chartConstructor
        self.fileValidator = fileValidator
        self.patternNormalizer = patternNormalizer
        self.nestedArrayBuilder = nestedArrayBuilder
    }

    public func run(userInput: [String], file: String? = nil, knitFlat: Bool = false) {
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
            print(chart)

        } catch {
            print(error.localizedDescription)
            exit(0)
        }

    }

    private func validateAndChartify(pattern: [String], knitFlat: Bool) throws -> String {
        let metaData = try inputValidator.inputValidation(pattern: pattern, knitFlat: knitFlat, nestedArrayBuilder: nestedArrayBuilder, patternNormalizer: patternNormalizer)
        return (chartConstructor.makeChart(patternMetaData: metaData))

    }
}
