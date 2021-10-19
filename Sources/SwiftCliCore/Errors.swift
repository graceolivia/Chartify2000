import Foundation

enum InputError: Error {
    case emptyRow
    case invalidStitch(invalidStitch: String)
}

enum FileError: Error {
    case unreadableFileType
}

func allowedStitches() -> String {
    var allowedStitchesMessage = "Allowed stitches include: "

    for stitch in allowedStitchesInfo {
        allowedStitchesMessage +=  "\n" + stitch.name
    }
    return allowedStitchesMessage

}
