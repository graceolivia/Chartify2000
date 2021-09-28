import Foundation
import ArgumentParser
// the allowable stitches

public final class Chartify {
    public init() {}
    public func run() {
        // Replace this variable with user input
        let input = "g1"
        let isValid = InputValidator().validate(pattern: input)
        if isValid == true {
            let patternArray = InputValidator().arrayMaker(cleanedpattern: input)
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
