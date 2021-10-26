import Foundation

public class FileValidator {
    public init() {}

    public func inputValidation(fileLocation: String) throws -> [String] {
        let urlVersion = URL(fileURLWithPath: fileLocation)
        guard urlVersion.pathExtension == "txt" else {
            throw ReadFilePath.invalidFileType
        }

        do {
            let contents = try String(contentsOf: urlVersion)
            let subLines = contents.split(separator: "\n")
            let lines = subLines.map { String($0) }
            return lines
        } catch {
            throw error
        }
    }
}
