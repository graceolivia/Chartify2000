import Foundation
import ArgumentParser

public final class Chartify {
    public init() {}
    public func run() {
        // Replace this variable with user input
        let input = "p1 k1 k1 k1 \n p1 k1 k1 yo k1 \n p1 k1 k1 k1 yo k1"
        let isValid = InputValidator().validate(pattern: input)
        if isValid == true {
            let patternArray = InputValidator().arrayMaker(cleanedPattern: input)
            print(ChartConstructor().makeChart(stitchArray: patternArray))
        } else {
            print("""
                  Your input was not formatted correctly.\
                  Please include only allowed stitches seperated by \\n for line breaks. \
 Current allowed input includes:
""")
            for stitch in allowedStitches {
                print(stitch)
            }
        }
    }
}
