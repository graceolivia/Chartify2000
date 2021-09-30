//
//  File.swift
//  
//
//  Created by Grace on 9/30/21.
//

import Foundation


public struct rowInfo{
    var row: [String]
    var rowNumber: Int
    var center: Int
    var leftIncDec: Int = 0
    var rightIncDec: Int = 0
    //This is about the number of "empty stitches" that should be added on the left to account for future increases
    var leftSpacing: Int = 0
}


public class OffsetUtility {
    public init() {}

    public func findCenter(stitchRow: [String]) -> Int {
        let center = floor(Double(stitchRow.count/2))
    return(Int(center))
    }

    public func findLeftChanges(stitchRow: [String]) -> Int {
        let center = findCenter(stitchRow: stitchRow)
        var totalLeftChange = 0
        for n in 0..<(center){
            if increases.contains(stitchRow[n]) {
                totalLeftChange += 1
            }
            if decreases.contains(stitchRow[n]) {
                totalLeftChange += -1
            }
        }
        return(totalLeftChange)
    }

    public func findRightChanges(stitchRow: [String]) -> Int {
        let center = findCenter(stitchRow: stitchRow)
        var totalRightChange = 0
        for n in center..<(stitchRow.count){
            if increases.contains(stitchRow[n]) {
                totalRightChange += 1
            }
            if decreases.contains(stitchRow[n]) {
                totalRightChange += -1
            }
        }
        return(totalRightChange)
    }

}
