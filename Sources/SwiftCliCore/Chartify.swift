import Foundation
import ArgumentParser

public final class Chartify {
    public init() {
    }
    public func run(userInput: String, inputValidator: InputValidator, chartConstructor: ChartConstructor) {

        let isValid = inputValidator.validate(pattern: userInput)
        if isValid {
            let patternArray = inputValidator.arrayMaker(cleanedPattern: userInput)
            print(chartConstructor.makeChart(stitchArray: patternArray))
        } else {
            print("""
                  Your input was not formatted correctly.\
                  Please include only allowed stitches seperated by \\n for line breaks. \
 Current allowed input includes:
""")
            for stitch in allowedUserInput {
                print(stitch)
            }
        }
    }
}
