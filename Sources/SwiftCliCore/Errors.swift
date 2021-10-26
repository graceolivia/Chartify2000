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
            return emptyRowError()
        case .invalidStitch(let invalidUserStitch):
            return invalidStitchError(invalidUserStitch: invalidUserStitch)
        case .invalidRowWidth(let invalidRowNumber, let expectedStitchCount, let actualCount):
            return invalidRowWidthError(
                invalidRowNumber: invalidRowNumber,
                expectedStitchCount: expectedStitchCount,
                actualCount: actualCount
            )
        }
    }
}

enum ReadFilePath: Error {
    case invalidFileType
    case noFileError
}

extension ReadFilePath: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidFileType:
            return "Only .txt files are current allowed"
        case .noFileError:
            return "Did you forget to add a file?"
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

func emptyRowError() -> String {
    return """
    Empty Row Error:
    All rows must contain stitches.
    You have submitted an empty string for at least one row.
    """
}

func invalidStitchError(invalidUserStitch: String) -> String {
    return(
        "Invalid Stitch Error: \n" +
        invalidUserStitch +
        " is not a valid stitch."
    )
}

func invalidRowWidthError(invalidRowNumber: Int, expectedStitchCount: Int, actualCount: Int) -> String {
    return( "Invalid Row Width Error: \nOn Row " +
            String(invalidRowNumber) +
            ", processor expects " +
            String(expectedStitchCount) +
            " stitches, but row has " +
            String(actualCount) +
            " instead. \nRewrite row " +
            String(invalidRowNumber) +
            " with valid stitch count.")
}
