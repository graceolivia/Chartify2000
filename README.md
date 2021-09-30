# Chartify

Turn your written knitting pattern into a handsome chart!

Chartify takes input in the form of allowed stitches, seperated by line breaks (eventually user input), and returns an ASCII chart.

For example, input the string "k1 k1 p1 p1 k1 k1 \n p1 p1 k1 k1 p1 p1," and Chartify will crate this pattern:

┌─┬─┬─┬─┬─┬─┐  
│-│-│ │ │-│-│
├─┼─┼─┼─┼─┼─┤
│ │ │-│-│ │ │
└─┴─┴─┴─┴─┴─┘

## How it Works

#### Processing The String

The user-added string is converted to a 2d array containing each row as an interior array. If we take the earlier example, "k1 k1 p1 p1 k1 k1 \n p1 p1 k1 k1 p1 p1", it would be converted to  

[["k1", "k1", "p1", "p1", "k1", "k1"],["p1", "p1", "k1", "k1", "p1", "p1"]]

#### Rendering The Chart

Because of the box-drawing characters used to draw the chart, the middle bars must be "drawn" keeping in mind both the row above and below's stitch counts, if there are increases or decreases, and what side (right of left) those increasees and decreases occur on. 

The chart drawing happens in phases. For each row, we draw the row-delineating-line below it, and then the row of stitches.

So, first, we would draw the bottom row:
│ │ │-│-│ │ │
└─┴─┴─┴─┴─┴─┘

Next, we would draw the next row:
│-│-│ │ │-│-│
├─┼─┼─┼─┼─┼─┤

Finally, after we have finished all the rows, we would add the top line:
┌─┬─┬─┬─┬─┬─┐ 


Current supported stitches/input, and how they are rendered:

| Stitch     | Rendering |
| ----------- | ----------- |
| k1      | blank box       |
| p1   | -        |
| ssk   | \        |
| k2tog   | /        |
| yo   | o        |
| m1   | m        |




## Developer information

Minimum Swift version required to run this project: 5.3

To install this project on your machine use 
`git clone https://github.com/graceolivia/Chartify2000.git`
`swift build`

To run the project, either use the Run command on XCODE, or cd into the directory on the terminal and do:


`swift run`

To test the project, either use XCODE tools to run tests as you wish, or in the project directory on the terminal run:

`swift test`
