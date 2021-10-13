import Foundation

public class InputValidator {
    public init() {}

    public func validate(pattern: String) throws -> Bool {
        let patternStitches = pattern.split(separator: " ")
        if patternStitches.count == 0 {
            throw RowParsingError.emptyRowError

        } do {
            let isItValid = try patternStitches.allSatisfy({ try stitchVerifier(stitch: String($0))  })
            return isItValid
        } catch {
            throw error
        }
    }

    public func arrayMaker(cleanedRow: String) throws -> [String] {
        let substringRowStitches = cleanedRow.split(separator: " ")
        let rowStitches = substringRowStitches.map {(String($0))}
        if rowStitches.count > 0 {
            return(rowStitches)
        } else {
            throw RowParsingError.emptyRowError
        }
    }
}
