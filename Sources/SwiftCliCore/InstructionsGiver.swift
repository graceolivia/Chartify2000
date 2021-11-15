import Foundation

public class InstructionsGiver {
    var consoleWriter: ConsoleWriter
    var fileValidator: FileValidator

    public init(consoleWriter: ConsoleWriter, fileValidator: FileValidator) {
        self.consoleWriter = consoleWriter
        self.fileValidator = fileValidator
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
        for stitch in repeatingStitches {
            message.append(stitch.name + "\n")
        }
        message.append("Non-repeating stitches:\n")
        for stitch in nonrepeatingStitches {
            message.append(stitch.name + "\n")
        }

        try consoleWriter.writeOutput(output: message)
    }

}
