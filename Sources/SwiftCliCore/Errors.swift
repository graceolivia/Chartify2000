

import Foundation

enum PatternValidationError: Error {
    case noStitches
    case invalidStitchFound
}

enum DeveloperError: Error {
    case inappropriateInput
}
