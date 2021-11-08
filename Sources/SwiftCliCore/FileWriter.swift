import Foundation

public class FileWriter {
    public init() {}

    public func writeFile(chart: String,
                          filePath: String,
                          fileName: String) throws {

        do {
            try chart.write(toFile: filePath + "//" + fileName + ".txt",
                            atomically: true,
                            encoding: .utf8)
        } catch {
            throw error
        }

    }
}
