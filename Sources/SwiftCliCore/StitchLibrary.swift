import Foundation

let allowedStitches = ["k1", "p1", "ssk", "k2tog", "yo", "m1", "\n"]
let stitchPrinting = ["k1": " ",
                      "p1": "-",
                      "ssk": "\\",
                      "k2tog": "/",
                      "yo": "o",
                      "m1": "m" ]

let increases = ["ssk", "k2tog"]
let decreases = ["m1", "yo"]

public struct stitchInfo{
    var name: String
    var printed: String
    //If the stitch is not an increase or decrease, value is 0. If it increases 1, value is 1. If it decreases 1, value is -1. Etc.
    var incDec: Int
}

public struct rowInfo{
    var row: [String]
    var center: Int
    var leftIncDec: Int
    var rightIncDec: Int
    //This is about the number of "empty stitches" that should be added on the left to account for future increases
    var leftSpacing: Int
}
