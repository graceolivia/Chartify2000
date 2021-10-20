import Foundation
import ArgumentParser

public final class Chartify {

    var inputValidator: InputValidator
    var chartConstructor: ChartConstructor

    public init(inputValidator: InputValidator, chartConstructor: ChartConstructor) {
        self.inputValidator = inputValidator
        self.chartConstructor = chartConstructor
    }

    public func run(userInput: [String]) {

        do {
            _ = try userInput.allSatisfy({ try inputValidator.validateEachStitch(row: $0) })
        } catch {
            print(error.localizedDescription)
            exit(0)
        }

        var patternArray: [[String]] = []
        do {
            patternArray = try userInput.map { try inputValidator.arrayMaker(cleanedRow: $0) }
            let patternMetaData = MetaDataBuilder().gatherAllMetaData(stitchArray: patternArray)
            _ = try inputValidator.validateEachRowWidth(allRowsMetaData: patternMetaData)
        } catch {
            print(error.localizedDescription)
            print("Visual representation of incorrect chart:")
            print(chartConstructor.makeChart(stitchArray: patternArray))
            exit(0)
        }

        print(chartConstructor.makeChart(stitchArray: patternArray))

    }
}
