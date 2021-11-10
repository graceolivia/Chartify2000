import Foundation

public protocol OutputWriter {

    func writeOutput(output: String) throws -> Void

}
