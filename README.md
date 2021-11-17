# Chartify

Turn your written knitting pattern into a handsome chart!

Chartify takes input in the form of allowed stitches, seperated by line breaks (eventually user input), and returns an ASCII chart.

For example, input the string "k1 k1 p1 p1 k1 k1 \n p1 p1 k1 k1 p1 p1," and Chartify will crate this pattern:

```
┌─┬─┬─┬─┬─┬─┐  
│-│-│ │ │-│-│
├─┼─┼─┼─┼─┼─┤
│ │ │-│-│ │ │
└─┴─┴─┴─┴─┴─┘
```
## How it Works

#### Processing The String

The user-added string is converted to a 2d array containing each row as an interior array. If we take the earlier example, "k1 k1 p1 p1 k1 k1 \n p1 p1 k1 k1 p1 p1", it would be converted to  

```
[["k1", "k1", "p1", "p1", "k1", "k1"],["p1", "p1", "k1", "k1", "p1", "p1"]]
```

#### Rendering The Chart

Because of the box-drawing characters used to draw the chart, the middle bars must be "drawn" keeping in mind both the row above and below's stitch counts, if there are increases or decreases, and what side (right of left) those increasees and decreases occur on. 

The chart drawing happens in phases. For each row, we draw the row-delineating-line below it, and then the row of stitches.

So, first, we would draw the bottom row:

```
│ │ │-│-│ │ │
└─┴─┴─┴─┴─┴─┘
```
Next, we would draw the next row:

```
│-│-│ │ │-│-│
├─┼─┼─┼─┼─┼─┤
```
Finally, after we have finished all the rows, we would add the top line:
```
┌─┬─┬─┬─┬─┬─┐ 
```

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
```
git clone https://github.com/graceolivia/Chartify2000.git
swift build
```

To run the project, either use the Run command on XCODE, or cd into the directory on the terminal and do:

`swift run`

Note that pattern needs to be written as a string or strings in quotes. One row would be entered as such:
`swift run SwiftCli "k1 k1 p1 p1 k1 k1"`

Multiple rows can be entered as seperate strings:

`swift run SwiftCli "k1 k1 p1 p1 k1 k1" "k1 k1 p1 p1 k1 k1" "k1 k1 p1 p1 k1 k1"`

In order to read in a file of rows seperated by line breaks, use this:

`swift run SwiftCli --file example.txt`

To indicate your pattern is supposed to be knit flat, with every other row intended to be knit as WS, add the `--knit-flat` command. Default value is knit in the round.

`swift run SwiftCli "k1 k1 p1 p1 k1 k1" "k1 k1 p1 p1 k1 k1" "k1 k1 p1 p1 k1 k1" --knit-flat`

To save the chart to a text file, use `  --output-file <filename>`:

`swift run SwiftCli "k1 k1 p1 p1 k1 k1" --output-file example`

You can indicate which directory you want to write to, or simply give a file name, in which case the file will be by default written to the directory Charify is run from.

To view the allowed stitches, use this command:

`swift run SwiftCli --stitches`

To test the project, either use XCODE tools to run tests as you wish, or in the project directory on the terminal run:

`swift test`


