import Foundation

public class FileWriter: OutputWriter {

    var filePath: String

    public init(filePath: String) {

        self.filePath = filePath

    }

    public func writeOutput(output: String) throws {

        do {
            try output.write(toFile: filePath + ".txt",
                             atomically: true,
                             encoding: .utf8)
        } catch {
            throw error
        }

    }
}
