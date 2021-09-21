import Foundation
import ArgumentParser
// the allowable stitches


public final class Chartify {
    public init() {}
    public func run() {
        print("Knitting!")
        print(ChartConstructor().make_chart(pattern: "k1 k1 p1 p1 k1 k1"))
    }
}
