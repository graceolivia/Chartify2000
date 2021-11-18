import Foundation

public struct PatternDataAndPossibleErrors: Equatable{
    var arrayOfStrings: [String] = []
    var arrayOfArrays: [[String]] = []
    var expandedArrayOfArrays: [[String]] = []
    var arrayOfRowInfo: [RowInfo] = []
    var results: [Result<Success, InputError>] = []
}

public enum Success: Equatable {
    case patternArray(_ input: [String])
    case patternNestedArray(_ input: [[String]])
    case patternRowInfo(_ input: [RowInfo])
}

public class InputValidator {

    var patternNormalizer = PatternNormalizer()
    var nestedArrayBuilder = NestedArrayBuilder()

    public init(patternNormalizer: PatternNormalizer, nestedArrayBuilder: NestedArrayBuilder) {

        self.patternNormalizer = patternNormalizer
        self.nestedArrayBuilder = nestedArrayBuilder
    }

    public func validateInput(pattern: [String], knitFlat: Bool = false) -> PatternDataAndPossibleErrors {

        var patternAndErrorResults = PatternDataAndPossibleErrors(arrayOfStrings: pattern)

        patternAndErrorResults.arrayOfStrings =  patternAndErrorResults.arrayOfStrings.map { patternNormalizer.makeAllLowercase(stitchesToLowercase: $0) }

        patternAndErrorResults.results  += checkNoEmptyRowsInArrayOfStrings(pattern: patternAndErrorResults.arrayOfStrings)


        patternAndErrorResults.arrayOfArrays =  patternAndErrorResults.arrayOfStrings.map { nestedArrayBuilder.arrayMaker(row: $0) } 

        if knitFlat == true {
            patternAndErrorResults.arrayOfArrays = knitFlatArray(array: patternAndErrorResults.arrayOfArrays)
        }

        patternAndErrorResults.results.append(checkNoInvalidStitchesInNestedArray(pattern: patternAndErrorResults.arrayOfArrays))


        patternAndErrorResults.results.append(checkRepeats(pattern: patternAndErrorResults.arrayOfArrays))



        for result in patternAndErrorResults.results {
            switch result {
            case .success:
                continue
            case .failure:
                return patternAndErrorResults
            }

        }


        patternAndErrorResults.arrayOfArrays = patternAndErrorResults.arrayOfArrays.map { nestedArrayBuilder.expandRow(row: $0) }
        patternAndErrorResults.arrayOfRowInfo = MetaDataBuilder().buildAllMetaData(stitchArray: patternAndErrorResults.arrayOfArrays)

                do { try checkNoMathematicalIssuesInArrayOfRowInfo(pattern: patternAndErrorResults.arrayOfRowInfo)} catch {print("todo")}
        return patternAndErrorResults


    }





private func checkNoEmptyRowsInArrayOfStrings(pattern: [String]) -> [Result<Success, InputError>] {
    var results: [Result<Success, InputError>] = []
    let isRowNonEmpty = pattern.map { !$0.isEmpty }
    if isRowNonEmpty.contains(false) {
        results.append(.failure(InputError.emptyRow()))
        // get all the indices where element is false and return those as .failure in Result
    } else {
        results.append(.success(Success.patternArray(pattern)))
}
    return results
}
private func checkNoInvalidStitchesInNestedArray(pattern: [[String]]) -> Result<Success, InputError> {
    let isEveryStitchValid = validateEachStitchInWholePattern(pattern: pattern)
    switch isEveryStitchValid {
    case .success:
        return .success(Success.patternNestedArray(pattern))
    case .failure(let error):
        return .failure(error)
    }

}

private func checkNoMathematicalIssuesInArrayOfRowInfo(pattern: [RowInfo]) -> Result<Success, InputError> {
    let isPatternMathematicallySound = validateEachRowWidth(allRowsMetaData: pattern)
    switch isPatternMathematicallySound {
    case .success:
        return .success(Success.patternRowInfo(pattern))
    case .failure(let error):
        return .failure(error)
    }
}

private func validateEachStitch(stitchRow: [String], rowIndex: Int) -> Result<[String], InputError> {

    var errorArray: [InputError] = []
    for (index, stitch) in stitchRow.enumerated() {
        if !isStitchValid(stitch: stitch) {
            errorArray.append(InputError.invalidStitch(invalidStitch: stitchRow[index], rowLocation: index + 1))
        }
    }

    if errorArray.count > 0 {
        return .failure(InputError.multipleErrors(errors: errorArray))
    }

    return .success(stitchRow)
}

private func validateEachStitchInWholePattern(pattern: [[String]]) -> Result<[[String]], InputError> {
    var errorArray: [InputError] = []
    for (rowIndex, row) in pattern.enumerated() {
        for (stitchIndex, stitch) in row.enumerated() {
            let result = isStitchAndStitchCountValid(stitch: stitch, rowNumber: rowIndex + 1, stitchIndex: stitchIndex + 1)
            switch result {
            case .success:
                continue
            case .failure(let error):
                errorArray.append(error)
            }

        }
    }

    if errorArray.count > 0 {
        return .failure(InputError.multipleErrors(errors: errorArray))
    }

    return .success(pattern)
}

private func validateNoEmptyRows(row: String) -> Result<String, InputError> {

    guard !row.isEmpty else {
        return .failure(InputError.emptyRow())
    }
    return .success(row)
}

private func validateEachRowWidth(allRowsMetaData: [RowInfo]) -> Result<[RowInfo], InputError> {
    let numberOfRowsToCheck = (allRowsMetaData.count) - 1
    if numberOfRowsToCheck == 0 {
        return .success(allRowsMetaData)
    }
    for rowNum in 1...numberOfRowsToCheck {
        let prevRow = allRowsMetaData[rowNum-1]
        var currentRow = allRowsMetaData[rowNum]
        if !isCurrentRowStitchCountValid(prevRow: prevRow, currentRow: currentRow) {
            let expectedNextRowWidth = prevRow.width + currentRow.leftIncDec + currentRow.rightIncDec
            return .failure(InputError.invalidRowWidth(
                invalidRowNumber: currentRow.userRowNumber,
                expectedStitchCount: expectedNextRowWidth,
                actualCount: currentRow.width
            ))
        }
    }
    return .success(allRowsMetaData)
}

private func isCurrentRowStitchCountValid(prevRow: RowInfo, currentRow: RowInfo) -> Bool {
    let expectedCurrentRowWidth = prevRow.width + currentRow.leftIncDec + currentRow.rightIncDec
    return expectedCurrentRowWidth == currentRow.width
}

public func knitFlatArray(array: [[String]]) -> [[String]] {
    let numberofRows = array.count
    var flatArray = array
    for rowNum in 0..<numberofRows where rowNum % 2 == 1 {
        flatArray[rowNum].reverse()
    }
    return flatArray
}

private func checkRepeats(pattern: [[String]]) -> Result<Success, InputError> {

    for (index, row) in pattern.enumerated() {
        for (index, stitch) in row.enumerated() {
            if let repeats = (stitch.range(of: "^[(0-9x)]*$", options: .regularExpression)) {
                let numberOfRepeats = Int(stitch.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
                guard numberOfRepeats! >= 1 else {
                    return .failure(InputError.invalidRepeatCount)
                }

            } else {
                continue
            }
        }
    }
    return .success(Success.patternNestedArray(pattern))
    }
}
