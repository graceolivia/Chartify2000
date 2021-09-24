
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
        let isItValid = pattern_stitches.allSatisfy({ allowed_stitches.contains(String($0)) })
        return isItValid
    }
    
    public func ArrayMaker(cleanedpattern: String) -> [[String]] {
        var stitch_array: [[String]] = []
        let pattern_rows = cleanedpattern.split(separator: "\n")
        for row in pattern_rows{
            var substring_pattern_stitches = row.split(separator: " ")
            var pattern_stitches = substring_pattern_stitches.map{(String($0))}
            if (pattern_stitches.count > 0){
                stitch_array.append(pattern_stitches)}
        }
        return(stitch_array)
    }
}
