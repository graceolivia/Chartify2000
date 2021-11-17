import Foundation

public class FileWriter: OutputWriter {

    var filePath: String
    var fileName: String

    public init(filePath: String, fileName: String) {
        self.filePath = filePath
        self.fileName = fileName
    }

    public func writeOutput(output: String) throws {

        do {
            try output.write(toFile: filePath + "//" + fileName + ".txt",
                            atomically: true,
                            encoding: .utf8)
        } catch {
            throw error
        }

    }
}
