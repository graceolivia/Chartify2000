import Foundation

enum InputError: Error, Equatable {
    case emptyRow
    case invalidStitch(invalidStitch: String, rowLocation: Int? = nil)
    case invalidRowWidth(invalidRowNumber: Int, expectedStitchCount: Int, actualCount: Int)
    case invalidStitchNumber(rowNumber: Int? = nil, invalidStitch: String, validStitchType: String, invalidStitchNumber: String)
}

extension InputError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .emptyRow:
            return emptyRowError()
        case .invalidStitch(let invalidStitch, let rowLocation):
            return invalidStitchWithLocationError(
                invalidStitch: invalidStitch,
                rowLocation: rowLocation
            )
        case .invalidRowWidth(let invalidRowNumber, let expectedStitchCount, let actualCount):
            return invalidRowWidthError(
                invalidRowNumber: invalidRowNumber,
                expectedStitchCount: expectedStitchCount,
                actualCount: actualCount
            )
        case .invalidStitchNumber(let rowNumber, let invalidStitch, let validStitchType, let invalidStitchNumber):
            return invalidStitchNumberError(
                rowNumber: rowNumber,
                invalidStitch: invalidStitch,
                validStitchType: validStitchType,
                invalidStitchCount: invalidStitchNumber
            )
        }
    }
}

enum ReadFilePathError: Error {
    case invalidFileType
}

extension ReadFilePathError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidFileType:
            return "Only .txt files are current allowed"
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

func invalidStitchWithLocationError(invalidStitch: String, rowLocation: Int?) -> String {
    if let location = rowLocation {
        return """
    Invalid Stitch Error:
    \(invalidStitch) on Row \(location) is not a valid stitch.
    """
    } else {
        return """
    Invalid Stitch Error:
    \(invalidStitch) is not a valid stitch.
    """
    }

}

func invalidStitchNumberError(rowNumber: Int?, invalidStitch: String, validStitchType: String, invalidStitchCount: String) -> String {
    if let rowNumber = rowNumber {
        return """
    Invalid Stitch Count Error:
    \(invalidStitch) on Row \(rowNumber) starts with valid stitch type \(validStitchType) but ends with the invalid stitch count \(invalidStitchCount). Please enter a positive integer number of stitches.
    """
    }
    else {
        return """
    Invalid Stitch Count Error:
    \(invalidStitch) starts with valid stitch type \(validStitchType) but ends with the invalid stitch count \(invalidStitchCount). Please enter a positive integer number of stitches.
    """
    }


}
