import Foundation

enum RowParsingError: Error {
    case emptyRowError
}

enum StitchParsingError: Error {
    case invalidInput(invalidStitch: String)
}
