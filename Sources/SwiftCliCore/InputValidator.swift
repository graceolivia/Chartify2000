import Foundation

extension Array{

    func forEachWithIndex(_ callback: (Int, Element) -> ()){

        for (index, element) in self.enumerated(){
            callback(index, element)
        }
    }
}

public struct PatternDataAndPossibleErrors: Equatable{
    var arrayOfStrings: [String] = []
    var arrayOfArrays: [[String]] = []
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

//
//        var patternNestedArray: [[String]]
//        do { patternNestedArray =  try patternAndErrorResults.arrayOfStrings.map { try nestedArrayBuilder.arrayMaker(row: $0) } }  catch { print("todo")  }
//
//        if knitFlat == true {
//
//            patternNestedArray = knitFlatArray(array: patternNestedArray)
//        }
//
//        do { try checkNoInvalidStitchesInNestedArray(pattern: patternNestedArray)} catch { print("todo") }
//
//        var expandedNestedArray: [[String]]
//        do { expandedNestedArray = try patternNestedArray.map { try nestedArrayBuilder.expandRow(row: $0) } } catch {print("todo")}
//
//        let patternMetaData = MetaDataBuilder().buildAllMetaData(stitchArray: expandedNestedArray)
//
//        do { try checkNoMathematicalIssuesInArrayOfRowInfo(pattern: patternMetaData)} catch {print("todo")}
        return PatternDataAndPossibleErrors()

    }
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
private func checkNoInvalidStitchesInNestedArray(pattern: [[String]]) throws -> [[String]] {
    let isEveryStitchValid = validateEachStitchInWholePattern(pattern: pattern)
    switch isEveryStitchValid {
    case .success:
        return pattern
    case .failure(let error):
        throw error
    }

}

private func checkNoMathematicalIssuesInArrayOfRowInfo(pattern: [RowInfo]) throws -> [RowInfo] {
    let isPatternMathematicallySound = validateEachRowWidth(allRowsMetaData: pattern)
    switch isPatternMathematicallySound {
    case .success:
        return pattern
    case .failure(let error):
        throw error
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
