import Foundation

let allowedStitches = ["k1", "p1", "ssk", "k2tog", "yo", "m1", "\n"]
let stitchPrinting = ["k1": " ",
                      "p1": "-",
                      "ssk": "\\",
                      "k2tog": "/",
                      "yo": "o",
                      "m1": "m" ]

let decreases = ["ssk", "k2tog"]
let increases = ["m1", "yo"]

public struct stitchInfo {
    var name: String
    var printed: String
    // If the stitch is not an increase or decrease, value is 0. If it increases 1, value is 1. If it decreases 1, value is -1. Etc.
    var incDec: Int
}
