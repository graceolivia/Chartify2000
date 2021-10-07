import Foundation

public class InputValidator {
    init() {}

    public func validate(pattern: String) -> Bool {
        let patternStitches = pattern.split(separator: " ")
        if patternStitches.count == 0 {
            return false
        }
        let isItValid = patternStitches.allSatisfy({ allowedUserInput.contains(String($0)) })
        return isItValid
    }

    public func arrayMaker(cleanedPattern: String) -> [[String]] {
        var stitchArray: [[String]] = []
        let patternRows = cleanedPattern.split(separator: "\n")
        for row in patternRows {
            let substringPatternStitches = row.split(separator: " ")
            let patternStitches = substringPatternStitches.map {(String($0))}
            if patternStitches.count > 0 {
                stitchArray.append(patternStitches)
            }
        }
        return(stitchArray)
    }

}
