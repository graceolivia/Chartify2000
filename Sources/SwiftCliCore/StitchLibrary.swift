import Foundation

struct StitchInfo: Equatable {
    var name: String
    var incDecValue: Int = 0
    var symbol: String
}

let allowedStitchesInfo = [StitchInfo(name: "k1", incDecValue: 0, symbol: " "),
                           StitchInfo(name: "p1", incDecValue: 0, symbol: "-"),
                           StitchInfo(name: "ssk", incDecValue: -1, symbol: "\\"),
                           StitchInfo(name: "k2tog", incDecValue: -1, symbol: "/"),
                           StitchInfo(name: "yo", incDecValue: 1, symbol: "o"),
                           StitchInfo(name: "m1", incDecValue: 1, symbol: "m")]

func getStitchInfo(stitch: String) throws -> StitchInfo {
    if let lookupStitch = allowedStitchesInfo.first(where: { $0.name == stitch }) {
        return lookupStitch
    }
    throw InputError.invalidStitch(invalidStitch: stitch)
}

func isStitchValid(stitch: String) -> Bool {
    let stitchLookup = allowedStitchesInfo.first(where: { $0.name == stitch })
    return(stitchLookup != nil)
}

