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
    return """
    Invalid Stitch Error:
    \(invalidUserStitch) is not a valid stitch.
    """
}

func invalidRowWidthError(invalidRowNumber: Int, expectedStitchCount: Int, actualCount: Int) -> String {
    let row = String(invalidRowNumber)
    let expectedCount = String(expectedStitchCount)
    let actualCount = String(actualCount)
    return( """
    Invalid Row Width Error:
    On Row \(row), processor expects \(expectedCount) stitches, but row has \(actualCount) instead.
    Rewrite row \(row) with valid stitch count.
    """
    )
}
