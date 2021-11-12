import Foundation

public class ConsoleWriter: OutputWriter {
    public init() {}

    public func writeOutput(output: String) throws {
        print(output)
    }

}
