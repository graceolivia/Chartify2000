
import Foundation

let allowed_stitches = ["k1", "p1",  "ssk", "k2tog", "yo", "m1", "\n"]
let stitchPrinting = ["k1":" ",
                      "p1":"-",
                      "ssk":"\\",
                      "k2tog":"/",
                      "yo":"o",
                      "m1":"m",]


public func arrayCompare(array1: [[String]], array2: [[String]]) -> Bool {
    var IsItTheSame : Bool! = nil
    if (array1 == array2){
        IsItTheSame = true
    }
    else{
        IsItTheSame = false
    }
    return IsItTheSame
}
