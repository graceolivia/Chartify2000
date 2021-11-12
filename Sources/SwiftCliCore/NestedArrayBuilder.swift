import Foundation

public class NestedArrayBuilder {
    public init() {}

    public func arrayMaker(row: String) -> [String] {
        let substringRowStitches = row.split(separator: " ")
        let rowStitches = substringRowStitches.map {(String($0))}
        return(rowStitches)
    }

    public func expandRow(row: [String]) throws ->  [String] {
        return try row.flatMap { try getMultipleStitchInfo(stitch: $0) }
    }

    private func getMultipleStitchInfo(stitch: String) throws -> [String] {
        if nonrepeatingStitches.contains(where: { $0.name == stitch }) {
            return [stitch]
        }
        let isRepeatingStitch = repeatingStitches.first(where: { stitch.starts(with: $0.name )})
        if let isRepeatingStitch = isRepeatingStitch {
            let stitchName = isRepeatingStitch.name
            var clipStitch = stitch
            clipStitch.removeAll(where: { stitchName.contains($0) })
            let stitchNameSuffix = clipStitch
            guard let repeatNumber = Int(stitchNameSuffix) else {
                throw InputError.invalidStitchNumber(
                    invalidStitch: stitch,
                    validStitchType: stitchName,
                    invalidStitchNumber: stitchNameSuffix
                )
            }

            guard repeatNumber >= 1 else {
                throw InputError.invalidStitchNumber(
                    invalidStitch: stitch,
                    validStitchType: stitchName,
                    invalidStitchNumber: stitchNameSuffix
                )
            }

            var stitchArray: [String] = []
            stitchArray.append(contentsOf: repeatElement((stitchName + "1"), count: repeatNumber))
            return stitchArray

        } else {
            return[stitch]
        }
    }

}
