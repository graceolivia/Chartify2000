import Foundation
import XCTest
import Nimble
@testable import SwiftCliCore

class NestedArrayMakerTest: XCTestCase {

    func testNestedArrayBuilderEmpty() throws {
        let result = NestedArrayBuilder().arrayMaker(row: "")
        expect(result).to(equal([]))
    }

    func testNestedArrayBuilder() throws {
        let result = NestedArrayBuilder().arrayMaker(row: "k1 k1 k1")
        expect(result).to(equal(["k1", "k1", "k1"]))
    }

}
