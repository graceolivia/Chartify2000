import Foundation

enum RowParsingError: Error {
    case EmptyRowError
}

enum StitchParsingError: Error {
    case invalidInput(invalidStitch: String)
}
