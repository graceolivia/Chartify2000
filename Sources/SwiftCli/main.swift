import SwiftCliCore

let inputValidator = InputValidator()
let chartify = Chartify(input: input, inputValidator: inputValidator)

let input = "p1 k1 k1 k1 \n p1 k1 k1 yo k1 \n p1 k1 k1 k1 yo k1"

chartify.run()
