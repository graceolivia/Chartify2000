import Foundation

public class FileWriter: OutputWriter {

    var fileNameAndPath: String


    public init(fileNameAndPath: String) {
        self.fileNameAndPath = fileNameAndPath
    }

    public func writeOutput(output: String) throws {

        do {
            try output.write(toFile: fileNameAndPath + ".txt",
                            atomically: true,
                            encoding: .utf8)
        } catch {
            throw error
        }

    }
}
