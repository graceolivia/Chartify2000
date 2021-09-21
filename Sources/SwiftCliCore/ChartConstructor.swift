
import Foundation

// printing class
public class ChartConstructor {
    public init() {}
    public func make_chart(pattern: String) -> String {
        let pattern_rows = pattern.components(separatedBy: "\n")
        let row_length = pattern_rows[0].components(separatedBy: " ").count
        let number_of_rows = pattern_rows.count
        var finished_chart = ""
        
        // Create top row bars
        let the_top_row_bars = self.make_top_row(width: row_length)
        finished_chart += the_top_row_bars;
        // Add each row of bars
        for row in pattern_rows{
            var stitch_row = self.make_stitch_row(row: row)
            finished_chart += stitch_row;
        }
        
        // Add botton bars
        let bottom_row_bars = self.make_bottom_row(width: row_length)
        finished_chart += bottom_row_bars
        

        return(finished_chart)
    }
    public func make_top_row(width: Int) -> String {
        var top_row_bars = ""
        if (width > 0){
        top_row_bars += "┌"
        if (width > 1){
        for n in 1...(width - 1) {
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
        for i in 1...(width - 1) {
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
        for i in 1...(width - 1) {
            bottom_row_bars += "─┴"
        }
        }
        bottom_row_bars += "─┘"
        }
        return(bottom_row_bars)
    }
    
    public func make_stitch_row(row: String) -> String {
        let pattern_stitches = row.components(separatedBy: " ")
        var stitch_row_symbols = ""
        if (row.count > 0 ) {
        stitch_row_symbols += "│"
        for stitch in pattern_stitches {
            stitch_row_symbols += stitchPrinting[stitch]!
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
