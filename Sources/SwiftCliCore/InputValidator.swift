
import Foundation

// validator class
public class Validator {
    init() {}
    // this will validate if the string contains only approved stitches
    public func validate(pattern: String) -> Bool {
        let pattern_stitches = pattern.components(separatedBy: " ")
        print(pattern_stitches)
        for stitch in pattern_stitches {
            if allowed_stitches.contains(stitch) == false{
                return false
            }
        }
        return true
    }
    public func ArrayMaker(cleanedpattern: String) -> [[String]] {
        var stitch_array: [[String]] = []
        let pattern_rows = cleanedpattern.components(separatedBy: "\n")
        for row in pattern_rows{
            var pattern_stitches = row.components(separatedBy: " ")
            pattern_stitches.removeAll(where: { $0 == "" })
            if (pattern_stitches.count > 0){
                stitch_array.append(pattern_stitches)}
        }
        return(stitch_array)
    }
}
