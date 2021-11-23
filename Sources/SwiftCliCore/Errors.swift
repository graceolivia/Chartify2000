import Foundation

enum InputError: Error, Equatable {
    case emptyRow(row: Int)
    case invalidStitch(
        invalidStitch: String,
        rowLocation: Int? = nil,
        stitchIndexInRow: Int? = nil
    )
    case invalidRowWidth(
        invalidRowNumber: Int,
        expectedStitchCount: Int,
        actualCount: Int
    )
    case invalidStitchNumber(
        rowNumber: Int? = nil,
        invalidStitch: String,
        validStitchType: String,
        invalidStitchNumber: String,
        stitchIndexInRow: Int? = nil
    )
    case multipleErrors(errors: [InputError])
    case invalidRepeatCount(
        rowNumber: Int,
        stitchIndexInRow: Int,
        invalidRepeat: String
    )

}

extension InputError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .emptyRow(let row):
            return emptyRowError(row: row)
        case .invalidStitch(let invalidStitch, let rowLocation, let stitchIndexInRow):
            return invalidStitchWithLocationError(
                invalidStitch: invalidStitch,
                rowLocation: rowLocation,
                stitchIndexInRow: stitchIndexInRow
            )
        case .invalidRowWidth(let invalidRowNumber, let expectedStitchCount, let actualCount):
            return invalidRowWidthError(
                invalidRowNumber: invalidRowNumber,
                expectedStitchCount: expectedStitchCount,
                actualCount: actualCount
            )
        case .invalidStitchNumber(let rowNumber, let invalidStitch, let validStitchType, let invalidStitchNumber, let stitchIndexInRow):
            return invalidStitchNumberError(
                rowNumber: rowNumber,
                invalidStitch: invalidStitch,
                validStitchType: validStitchType,
                invalidStitchCount: invalidStitchNumber,
                stitchIndexInRow: stitchIndexInRow
            )

        case .invalidRepeatCount(let rowNumber, let stitchIndexInRow, let invalidRepeat):
            return invalidRepeatCountError(
                rowNumber: rowNumber,
                stitchIndexInRow: stitchIndexInRow,
                invalidRepeat: invalidRepeat
            )

        case .multipleErrors(let errors):
            return multipleErrorsMessage(errors: errors)

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

    for stitch in StitchLibrary().allowedStitchesInfo {
        allowedStitchesMessage +=  "\n" + stitch.name
    }
    return allowedStitchesMessage
}

func emptyRowError(row: Int) -> String {
    return """
    Empty Row Error:
    All rows must contain stitches.
    You have submitted an empty row on row \(row).
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

func invalidStitchWithLocationError(invalidStitch: String, rowLocation: Int?, stitchIndexInRow: Int?) -> String {
    var onRow = ""
    var atIndex = ""
    if let rowLocation = rowLocation {
        onRow = " on row \(rowLocation)"
    }
    if let stitchIndexInRow = stitchIndexInRow {
        atIndex = " at index \(stitchIndexInRow)"
    }

    return """
    Invalid Stitch Error:
    '\(invalidStitch)'\(atIndex)\(onRow) is not a valid stitch type.
    """

}

func invalidStitchNumberError(rowNumber: Int?, invalidStitch: String, validStitchType: String, invalidStitchCount: String, stitchIndexInRow: Int?) -> String {
    var onRow = ""
    var atIndex = ""
    if let rowNumber = rowNumber {
        onRow = " on row \(rowNumber)"
    }
    if let stitchIndexInRow = stitchIndexInRow {
        atIndex = " at index \(stitchIndexInRow)"
    }

    return """
    Invalid Stitch Count Error:
    '\(invalidStitch)'\(atIndex)\(onRow) starts with valid stitch type \(validStitchType) but ends with the invalid stitch count \(invalidStitchCount). Please enter a positive integer number of stitches.
    """

}

func multipleErrorsMessage(errors: [InputError]) -> String {
    var allErrorMessages = ""
    for error in errors {
        allErrorMessages.append(error.localizedDescription)
        allErrorMessages.append("\n")
    }
    return allErrorMessages

}

func invalidRepeatCountError(rowNumber: Int? = nil, stitchIndexInRow: Int? = nil, invalidRepeat: String? = nil ) -> String {
    var onRow = ""
    var atIndex = ""
    var badRepeatString  = ""
    if let rowNumber = rowNumber {
        onRow = " on row \(rowNumber)"
    }
    if let stitchIndexInRow = stitchIndexInRow {
        atIndex = " at index \(stitchIndexInRow)"
    }
    if let invalidRepeat = invalidRepeat {
        badRepeatString = "'\(invalidRepeat)'"
    }

    return """
    Invalid Stitch Count Error:
    One of your repeat notations \(badRepeatString)\(atIndex)\(onRow) has an invalid stitch count.
    Stitch repeat number must be at least 1.
    """
}
