import Foundation
import ArgumentParser
// the allowable stitches


public final class Chartify {
    public init() {}
    public func run() {
        print("Knitting!")
        // Replace this variable with user input
        let input = "g1"
        let isValid = InputValidator().validate(pattern: input)
        if (isValid == true){
            let patternArray = InputValidator().ArrayMaker(cleanedpattern: input)
            print(ChartConstructor().make_chart(stitch_array: patternArray))
        }
        else{
            print("Your input was not formatted correctly. Please include only allowed stitches seperated by \\n for line breaks. Current allowed input includes:")
            for s in allowed_stitches{
                print(s)
            }
        }
    }
}
