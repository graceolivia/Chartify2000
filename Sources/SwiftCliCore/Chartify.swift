import Foundation
import ArgumentParser
// the allowable stitches


public final class Chartify {
    public init() {}
    public func run() {
        print("Knitting!")
        // Replace this variable with user input
        let input = "k1 k1 p1 p1 k1 k1"
        let isValid = Validator().validate(pattern: input)
        if (isValid == true){
            let patternArray = Validator().ArrayMaker(cleanedpattern: input)
            print(ChartConstructor().make_chart(stitch_array: patternArray))
        }
        else{
            print("Failed.")
        }
    }
}
