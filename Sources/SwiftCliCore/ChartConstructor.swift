
import Foundation

public class ChartConstructor {
    public init() {}
    public func make_chart(stitch_array: [[String]]) -> String {
        
        let number_of_rows = stitch_array.count
        var finished_chart = ""
        let lastrow = number_of_rows - 1
        
        for row in 0...lastrow {
            let row_length = stitch_array[row].count
            
            if (row == 0){
                finished_chart =  makeBottomRow(width: row_length) + finished_chart
                finished_chart = makeStitchRow(row: stitch_array[row]) + finished_chart
            }
            
            
            else {
                let prev_row_length = stitch_array[row - 1].count
                let right_side_diff = (row_length - prev_row_length)
                if (right_side_diff < 0){
                    
                    finished_chart =  makeMiddleRowStitchCountChange(width: row_length, right_difference: right_side_diff, left_difference: 0) + finished_chart
                }
                else {
                    finished_chart = makeMiddleRow(width: row_length) + finished_chart
                }
                
                finished_chart = makeStitchRow(row: stitch_array[row]) + finished_chart
                
            }
            
            
            if (row == (number_of_rows - 1)){
                finished_chart = makeTopRow(width: row_length) + finished_chart
                
            }
            
        }
        
        
        
        return(finished_chart)
    }
    public func makeTopRow(width: Int) -> String {
        var top_row_bars = ""
        if (width > 0){
            top_row_bars += "┌"
            if (width > 1){
                top_row_bars += String(repeating: "─┬", count: width - 1)
                
            }
            top_row_bars += "─┐"
        }
        top_row_bars += "\n"
        return(top_row_bars)
    }
    public func makeMiddleRow(width: Int) -> String {
        var middleRowBars = ""
        if (width > 0){
            middleRowBars += "├"
            if (width > 1){
                middleRowBars += String(repeating: "─┼", count: width - 1)
            }
            middleRowBars += "─┤"
        }
        middleRowBars += "\n"
        return(middleRowBars)
    }
    
    public func makeMiddleRowStitchCountChange(width: Int, right_difference: Int, left_difference: Int) -> String {
        
        var middle_row_bars = ""
        if (width > 0){
            middle_row_bars += "├"
            if (right_difference < 0){
                middle_row_bars += String(repeating: "─┼", count: (width))
                if (abs(right_difference) >= 2){
                    middle_row_bars += String(repeating: "─┬", count: ((abs(right_difference))-1))
                    
                }
                middle_row_bars += "─┐"
            }
        }
        middle_row_bars += "\n"
        return(middle_row_bars)
    }
    
    
    
    public func makeBottomRow(width: Int) -> String {
        var bottom_row_bars = ""
        if (width > 0) {
            bottom_row_bars += "└"
            if (width > 1){
                bottom_row_bars += String(repeating: "─┴", count: width - 1)
            }
            bottom_row_bars += "─┘"
        }
        return(bottom_row_bars)
    }
    
    public func makeStitchRow(row: [String]) -> String {
        var stitch_row_symbols = ""
        if (row[0] != "" ) {
            stitch_row_symbols += "│"
            for stitch in row {
                stitch_row_symbols += stitchPrinting[stitch] ?? ""
                stitch_row_symbols += "│"
            }
        }
        stitch_row_symbols += "\n"
        return(stitch_row_symbols)
    }
}
