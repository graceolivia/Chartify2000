import Foundation

struct StitchInfo {
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

let nonStitchAllowedInput = ["\n"]

let allowedUserInput = allowedStitchesInfo.map { $0.name } + nonStitchAllowedInput
