
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

}
