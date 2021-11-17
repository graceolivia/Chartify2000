import Foundation

struct StitchType: Equatable {
    var name: String
    var canRepeat: Bool
    var incDecValue: Int = 0
    var symbol: String
}

let allowedStitchesInfo = [StitchType(name: "k", canRepeat: true, incDecValue: 0, symbol: " "),
                           StitchType(name: "p", canRepeat: true, incDecValue: 0, symbol: "-"),
                           StitchType(name: "ssk", canRepeat: false, incDecValue: -1, symbol: "\\"),
                           StitchType(name: "k2tog", canRepeat: false, incDecValue: -1, symbol: "/"),
                           StitchType(name: "yo", canRepeat: false, incDecValue: 1, symbol: "o"),
                           StitchType(name: "m1", canRepeat: false, incDecValue: 1, symbol: "m")]

let nonrepeatingStitches = allowedStitchesInfo.filter({ !$0.canRepeat })

let repeatingStitches = allowedStitchesInfo.filter({ $0.canRepeat })

func getStitchInfo(stitch: String) throws -> StitchType {
    if let lookupStitch = nonrepeatingStitches.first(where: { $0.name == stitch }) {
        return lookupStitch
    } else if let lookupStitch = repeatingStitches.first(where: { stitch.starts(with: $0.name )}) {
        return lookupStitch
    } else {throw InputError.invalidStitch(invalidStitch: stitch)}

}

func isStitchValid(stitch: String) -> Bool {
    let isNonrepeatingStitch = nonrepeatingStitches.contains(where: { $0.name == stitch })
    if isNonrepeatingStitch {
        return true
    } else {
        let stitchNameMatch = repeatingStitches.first(where: { stitch.starts(with: $0.name )})
        if let stitchFound = stitchNameMatch {
            let stitchName = stitchFound.name
            var clipStitch = stitch
            clipStitch.removeAll(where: { stitchName.contains($0) })
            let stitchNameSuffix = clipStitch
            let tryToConvertStitchSuffixToInt: Int? = Int(stitchNameSuffix)
            if tryToConvertStitchSuffixToInt != nil {
                return true
            }
        } else {
            return false
        }
    }
    return false
}

func isStitchAndStitchCountValid(stitch: String, rowNumber: Int, stitchIndex: Int) -> Result<String, InputError> {
    guard isStitchValid(stitch: stitch) else {
        return .failure(InputError.invalidStitch(invalidStitch: stitch, rowLocation: rowNumber, stitchIndexInRow: stitchIndex))
    }
    if nonrepeatingStitches.contains(where: { $0.name == stitch }) {
        return .success(stitch)
    }
    else {
        let isRepeatingStitch = repeatingStitches.first(where: { stitch.starts(with: $0.name )})
        return determineIfRepeatingStitchIsACorrectRepeatingStitch(stitch: stitch, stitchType: isRepeatingStitch!, rowNumber: rowNumber, stitchIndex: stitchIndex)
    }

}



private func determineIfRepeatingStitchIsACorrectRepeatingStitch(stitch: String, stitchType: StitchType, rowNumber: Int, stitchIndex: Int) -> Result<String, InputError> {
    let stitchName = stitchType.name
    var clipStitch = stitch
    clipStitch.removeAll(where: { stitchName.contains($0) })
    let stitchNameSuffix = clipStitch
    guard let repeatNumber = Int(stitchNameSuffix) else {
        return .failure(InputError.invalidStitchNumber(
            rowNumber: rowNumber,
            invalidStitch: stitch,
            validStitchType: stitchName,
            invalidStitchNumber: stitchNameSuffix,
            stitchIndexInRow: stitchIndex
        ))
    }

    guard repeatNumber >= 1 else {
        return .failure(InputError.invalidStitchNumber(
            rowNumber: rowNumber,
            invalidStitch: stitch,
            validStitchType: stitchName,
            invalidStitchNumber: stitchNameSuffix,
            stitchIndexInRow: stitchIndex
        ))
    }

    var stitchArray: [String] = []
    stitchArray.append(contentsOf: repeatElement((stitchName + "1"), count: repeatNumber))
    return .success(stitch)

}
