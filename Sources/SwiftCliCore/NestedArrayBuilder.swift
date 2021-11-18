import Foundation

public class NestedArrayBuilder {
    public init() {}

    public func arrayMaker(row: String) -> [String] {
        let substringRowStitches = row.split(separator: " ")
        let rowStitches = substringRowStitches.map {(String($0))}
        // let expandedRowStitches = try handleRepeats(row: rowStitches)
        return(rowStitches)
    }

    public func expandRow(row: [String]) -> [String] {
        var rowWithExpandedMultipleStitches: [String] = []
        do { try rowWithExpandedMultipleStitches = row.flatMap { try getMultipleStitchInfo(stitch: $0) } } catch { return row }
        do { return try handleRepeats(row: rowWithExpandedMultipleStitches) } catch { return rowWithExpandedMultipleStitches }
    }

    private func handleRepeats(row: [String]) throws -> [String] {

        var repeatedRow: [String] = []
        var currentRowSection: [String] = []
        for (index, stitch) in row.enumerated() {
            if let _ = (stitch.range(of: "^[(0-9x)]*$", options: .regularExpression)) {
                let numberOfRepeats = Int(stitch.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
                guard numberOfRepeats! >= 1 else {
                    throw InputError.invalidRepeatCount()

                }
                for _ in 1...numberOfRepeats! { repeatedRow += currentRowSection }
                currentRowSection = []
            } else {
                currentRowSection.append(stitch)
            }
        }
        repeatedRow += currentRowSection

        return repeatedRow
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

                return [stitch]
            }

            guard repeatNumber >= 1 else {
                return [stitch]

            }

            var stitchArray: [String] = []
            stitchArray.append(contentsOf: repeatElement((stitchName + "1"), count: repeatNumber))
            return stitchArray

        } else {
            return[stitch]
        }
    }

}
