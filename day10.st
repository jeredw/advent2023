file := FileStream fileNamed: 'day10-input.txt'.
grid := Day10Grid new init: ((file contentsOfEntireFile) splitBy: String lf).

Transcript clear.
Transcript show: (grid loopSemiPerimeter); cr.
Transcript show: (grid loopArea); cr.