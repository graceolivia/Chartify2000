import Foundation

public class NestedArrayBuilder {
    public init() {}

    public func arrayMaker(row: String) -> [String] {
        let substringRowStitches = row.split(separator: " ")
        let rowStitches = substringRowStitches.map {(String($0))}
        return(rowStitches)
    }
}
