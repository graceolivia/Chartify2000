import Foundation

let stitchPrinting = ["k1": " ",
                      "p1": "-",
                      "ssk": "\\",
                      "k2tog": "/",
                      "yo": "o",
                      "m1": "m" ]

let decreases = ["ssk", "k2tog"]
let increases = ["m1", "yo"]

struct stitchInfo {
    var name: String
    var incDecValue: Int = 0
    var symbol: String
}

let allowedStitchesInfo = [stitchInfo(name: "k1", incDecValue: 0, symbol: " "),
                           stitchInfo(name: "p1", incDecValue: 0, symbol: "-"),
                           stitchInfo(name: "ssk", incDecValue: -1, symbol: "\\"),
                           stitchInfo(name: "k2tog", incDecValue: -1, symbol: "/"),
                           stitchInfo(name: "yo", incDecValue: 1, symbol: "o"),
                           stitchInfo(name: "m1", incDecValue: 1, symbol: "m")]

let allowedStitches = ["k1", "p1", "ssk", "k2tog", "yo", "m1", "\n"]
