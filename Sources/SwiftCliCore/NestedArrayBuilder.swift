import Foundation

public class NestedArrayBuilder {
    public init() {}

    public func arrayMaker(row: String) -> [String] {
        let substringRowStitches = row.split(separator: " ")
        let rowStitches = substringRowStitches.map {(String($0))}
        return(rowStitches)
    }

    public func expandRow(row: [String]) -> [String] {
        let expandedRow = row.flatMap { getMultipleStitchInfo(stitch: $0) }
        return expandedRow
    }

    private func getMultipleStitchInfo(stitch: String) -> [String] {
        let isRepeatingStitch = repeatingStitches.first(where: { stitch.starts(with: $0.name )})
        if let isRepeatingStitch = isRepeatingStitch {
            let stitchName = isRepeatingStitch.name
            var clipStitch = stitch
            clipStitch.removeAll(where: { stitchName.contains($0) })
            let stitchNameSuffix = clipStitch
            let repeatNumber = Int(stitchNameSuffix)
            var stitchArray: [String] = []
            stitchArray.append(contentsOf: repeatElement((stitchName + "1"), count: repeatNumber!))
            return stitchArray

        }
        else {
            return[stitch]
        }
    }


}
