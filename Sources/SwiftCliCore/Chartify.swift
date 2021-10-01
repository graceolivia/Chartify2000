import Foundation
import ArgumentParser


// Replace this variable with user input
let userInput = "k1 k1 k1 \n ssk k1 \n"


public final class Chartify {
    public init() {}
    public func run() {

        let isValid = InputValidator().validate(pattern: userInput)
        if isValid {
            let patternArray = InputValidator().arrayMaker(cleanedPattern: userInput)
            print(ChartConstructor().makeChart(stitchArray: patternArray))
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
