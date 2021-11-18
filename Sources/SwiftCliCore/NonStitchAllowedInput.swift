import Foundation

public class NonStitchAllowedNotation {

    public init() {}

    public func isRepeat(potentialRepeat: String) -> Bool {
        if let _ = (potentialRepeat.range(of: "^[(0-9x)]*$", options: .regularExpression)){
            return true
            }
        else {
            return false
        }

    }

    public func isValidRepeat(repeat: String) -> Bool {

//            if let isValidRepeat = (repeat.range(of: "^[(0-9x)]*$", options: .regularExpression)){
//                let numberOfRepeats = Int(isValidRepeat.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
//                guard (numberOfRepeats! >= 1) else {
//                    return .failure(InputError.invalidRepeatCount)
//                }
//            }
return true
    }
}
