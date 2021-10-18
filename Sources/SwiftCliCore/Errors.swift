import Foundation

enum InputError: Error {
    case emptyRow
    case invalidStitch(invalidStitch: String)
    case invalidRowWidth(invalidRowNumber: Int, expectedStitchCount: Int, actualCount: Int)
}
extension InputError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .emptyRow:
            return """
Empty Row Error:
All rows must contain stitches.
You have submitted an empty string for at least one row.
"""
        case .invalidStitch(let invalidUserStitch):
            return (
                "Invalid Stitch Error: \n" +
                invalidUserStitch +
                " is not a valid stitch."
            )
        case .invalidRowWidth(let invalidRowNumber, let expectedStitchCount, let actualCount):
            let errorLocationMessage = "Invalid Row Width Error: \nOn Row " +
            String(invalidRowNumber) +
            ", processor expects " +
            String(expectedStitchCount) +
            " stitches, but row has " +
            String(actualCount) +
            " instead. \nRewrite row " +
            String(invalidRowNumber) +
            " with valid stitch count."

            return (errorLocationMessage)
        }
    }

}

func allowedStitches() -> String {
    var allowedStitchesMessage = "Allowed stitches include: "

    for stitch in allowedStitchesInfo {
        allowedStitchesMessage +=  "\n" + stitch.name
    }
    return allowedStitchesMessage

}
