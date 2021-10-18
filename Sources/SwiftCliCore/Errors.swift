import Foundation

enum InputError: Error {
    case emptyRow
    case invalidStitch(invalidStitch: String)
    case impossiblePattern(invalidRowNumber: Int, expectedStitchCount: Int, actualCount: Int)
}

func allowedStitches() -> String {
    var allowedStitchesMessage = "Allowed stitches include: "

    for stitch in allowedStitchesInfo {
        allowedStitchesMessage +=  "\n" + stitch.name
    }
    return allowedStitchesMessage

}
