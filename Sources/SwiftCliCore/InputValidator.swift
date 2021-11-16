import Foundation

public class InputValidator {

    var patternNormalizer = PatternNormalizer()
    var nestedArrayBuilder = NestedArrayBuilder()

    public init(patternNormalizer: PatternNormalizer, nestedArrayBuilder: NestedArrayBuilder) {

        self.patternNormalizer = patternNormalizer
        self.nestedArrayBuilder = nestedArrayBuilder
    }

    public func validateInput(pattern: [String], knitFlat: Bool = false) throws -> [RowInfo] {

        var results:[Any] = []

        let lowercaseNormalizedPattern =  pattern.map { patternNormalizer.makeAllLowercase(stitchesToLowercase: $0) }


        let areThereNoEmptyRows = checkNoEmptyRowsInArrayOfStrings(pattern: lowercaseNormalizedPattern)
        results.append(areThereNoEmptyRows)


        var patternNestedArray =  try lowercaseNormalizedPattern.map { try nestedArrayBuilder.arrayMaker(row: $0) }

        if knitFlat == true {

            patternNestedArray = knitFlatArray(array: patternNestedArray)
        }

        try checkNoInvalidStitchesInNestedArray(pattern: patternNestedArray)

        let expandedNestedArray = try patternNestedArray.map { try nestedArrayBuilder.expandRow(row: $0) }

        let patternMetaData = MetaDataBuilder().buildAllMetaData(stitchArray: expandedNestedArray)

        return try checkNoMathematicalIssuesInArrayOfRowInfo(pattern: patternMetaData)

    }
}

private func checkNoEmptyRowsInArrayOfStrings(pattern: [String]) -> Result<[String], InputError>  {
    for row in pattern {
        let isEmptyRow = validateNoEmptyRows(row: row)
        switch isEmptyRow {
        case .success:
            continue
        case .failure(let error):
            return .failure(error)
        }
    }
    return .success(pattern)
}

private func checkNoInvalidStitchesInNestedArray(pattern: [[String]]) -> Result<[[String]], InputError>  {
    let isEveryStitchValid = validateEachStitchInWholePattern(pattern: pattern)
    switch isEveryStitchValid {
    case .success:
        return .success(pattern)
    case .failure(let error):
        return .failure(error)
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
        return .failure(InputError.emptyRow)
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
