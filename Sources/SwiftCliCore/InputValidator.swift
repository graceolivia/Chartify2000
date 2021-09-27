
import Foundation

// validator class
public class InputValidator {
    init() {}
    
    // this will validate if the string contains only approved stitches
    public func validate(pattern: String) -> Bool {
        let pattern_stitches = pattern.split(separator: " ")
        if pattern_stitches.count == 0 {
            return false
        }
        let isItValid = pattern_stitches.allSatisfy({ allowedStitches.contains(String($0)) })
        return isItValid
    }
    
    
    
    public func arrayMaker(cleanedpattern: String) -> [[String]] {
        var stitchArray: [[String]] = []
        let patternRows = cleanedpattern.split(separator: "\n")
        for row in patternRows{
            let substringPatternStitches = row.split(separator: " ")
            let patternStitches = substringPatternStitches.map{(String($0))}
            if (patternStitches.count > 0){
                stitchArray.append(patternStitches)}
        }
        return(stitchArray)
    }
    
}
