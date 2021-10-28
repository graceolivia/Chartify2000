import Foundation

public class FileValidator {
    public init() {}

    public func inputValidation(fileLocation: String) throws -> [String] {
        let fileLocationURL = URL(fileURLWithPath: fileLocation)
        guard fileLocationURL.pathExtension == "txt" else {
            throw ReadFilePathError.invalidFileType
        }

        do {
            let contents = try String(contentsOf: fileLocationURL)
            let subLines = contents.split(separator: "\n")
            let lines = subLines.map { String($0) }
            return lines
        } catch {
            throw error
        }
    }
}
