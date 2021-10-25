import Foundation

public class FileValidator {
    public init() {}

    public func inputValidation(fileLocation: String?) throws -> [String] {

        guard fileLocation != nil else {
            throw FileUploadError.noFileError
        }

        guard fileLocation!.suffix(4) == ".txt" else {
            print("Only files with .txt extension are allowed")
            throw FileUploadError.invalidFileType
        }
        do {
            let contents = try String(contentsOfFile: fileLocation!)
            let subLines = contents.split(separator: "\n")
            let lines = subLines.map { String($0) }
            return lines
        } catch {
            throw error
        }
    }
}
