
import Foundation

public class ChartConstructor {
    public init() {}
    public func make_chart(stitch_array: [[String]]) -> String {
        
        let number_of_rows = stitch_array.count
        var finished_chart = ""
        let lastrow = number_of_rows - 1
        // NEW LOGIC
        for row in 0...lastrow {
            let row_length = stitch_array[row].count
            if (row == 0){
                finished_chart =  self.make_bottom_row(width: row_length) + finished_chart
                finished_chart = self.make_stitch_row(row: stitch_array[row]) + finished_chart
            }
            
            
            else {

                
                finished_chart = self.make_middle_row(width: row_length) + finished_chart
                finished_chart = self.make_stitch_row(row: stitch_array[row]) + finished_chart

                }
            
            //if last row
            if (row == (number_of_rows - 1)){
                finished_chart = self.make_top_row(width: row_length) + finished_chart

            }

        }
        
        
        
        return(finished_chart)
    }
    public func make_top_row(width: Int) -> String {
        var top_row_bars = ""
        if (width > 0){
            top_row_bars += "┌"
            if (width > 1){
                for _ in 1...(width - 1) {
                    top_row_bars += "─┬"
                }
            }
            top_row_bars += "─┐"
        }
        top_row_bars += "\n"
        return(top_row_bars)
    }
    public func make_middle_row(width: Int) -> String {
        var middle_row_bars = ""
        if (width > 0){
            middle_row_bars += "├"
            if (width > 1){
                for _ in 1...(width - 1) {
                    middle_row_bars += "─┼"
                }
            }
            middle_row_bars += "─┤"
        }
        middle_row_bars += "\n"
        return(middle_row_bars)
    }
    public func make_bottom_row(width: Int) -> String {
        var bottom_row_bars = ""
        if (width > 0) {
            bottom_row_bars += "└"
            if (width > 1){
                for _ in 1...(width - 1) {
                    bottom_row_bars += "─┴"
                }
            }
            bottom_row_bars += "─┘"
        }
        return(bottom_row_bars)
    }
    
    public func make_stitch_row(row: [String]) -> String {
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


//┌─┬─┬─┬─┐
//│k│p│k│p│
//├─┼─┼─┼─┤
//│p│k│p│k│
//└─┴─┴─┴─┘
