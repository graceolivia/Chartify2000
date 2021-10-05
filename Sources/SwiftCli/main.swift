import SwiftCliCore

let inputValidator = InputValidator()
let chartify = Chartify()

let input = "p1 k1 k1 k1 \n p1 k1 k1 yo k1 \n p1 k1 k1 k1 yo k1"

chartify.run(input: input, inputValidator: inputValidator)
