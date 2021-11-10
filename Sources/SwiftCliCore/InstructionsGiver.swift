import Foundation

public class InstructionsGiver {
    var consoleWriter: ConsoleWriter

    public init(consoleWriter: ConsoleWriter) {
        self.consoleWriter = consoleWriter
    }
    public func giveInstructions() throws -> Void {
        let allowedFileTypes = ".txt"
        var message = "Chartify takes in written patterns, either on the command line or in \(allowedFileTypes) files, and returns charts. Current allowed stitches are listed below.\n"
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
