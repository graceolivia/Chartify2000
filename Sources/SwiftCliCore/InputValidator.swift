import Foundation

public class InputValidator {
    public init() {}

    public func validate(row: String) throws -> Bool {
        let rowStitches = row.split(separator: " ")
        guard rowStitches.count > 0 else {
            throw InputError.emptyRow
        }

        for stitch in rowStitches {
            guard isStitchValid(stitch: String(stitch)) == true else {
                throw InputError.invalidStitch(invalidStitch: String(stitch))
            }

        }
        return true
    }

    public func arrayMaker(cleanedRow: String) throws -> [String] {
        let substringRowStitches = cleanedRow.split(separator: " ")
        let rowStitches = substringRowStitches.map {(String($0))}
        guard rowStitches.count > 0  else {
            throw InputError.emptyRow
        }
        return(rowStitches)

    }

}
