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


