# Chartify

Turn your written knitting pattern into a handsome chart!

Chartify takes input in the form of allowed stitches, seperated by line breaks (eventually user input), and returns an ASCII chart.

For example, input the string "k1 k1 p1 p1 k1 k1 \n p1 p1 k1 k1 p1 p1," and Chartify will crate this pattern:

┌─┬─┬─┬─┬─┬─┐  
│-│-│ │ │-│-│
├─┼─┼─┼─┼─┼─┤
│ │ │-│-│ │ │
└─┴─┴─┴─┴─┴─┘


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
