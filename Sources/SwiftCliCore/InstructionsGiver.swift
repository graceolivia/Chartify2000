import Foundation

public class InstructionsGiver {
    var consoleWriter: ConsoleWriter
    var fileValidator: FileValidator
    var stitchLibrary: StitchLibrary

    public init(consoleWriter: ConsoleWriter, fileValidator: FileValidator, stitchLibrary: StitchLibrary) {
        self.consoleWriter = consoleWriter
        self.fileValidator = fileValidator
        self.stitchLibrary = stitchLibrary
    }
    public func giveInstructions() throws {

        var message = """
Chartify takes in written patterns, either on the command line or in allowed file types, and returns charts.

Allowed file types include:\n
"""
        for filetype in fileValidator.allowedFileTypes { message.append(filetype + "\n") }
        message.append("""
\nCurrent allowed stitches are listed below.\n\n
""")
        message.append("Repeating stitches (can be written with any number 1 or greater afterwards: \n")
        for stitch in stitchLibrary.repeatingStitches {
            message.append(stitch.name + "\n")
        }
        message.append("Non-repeating stitches:\n")
        for stitch in stitchLibrary.nonrepeatingStitches {
            message.append(stitch.name + "\n")
        }

        try consoleWriter.writeOutput(output: message)
    }

}
