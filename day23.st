file := FileStream fileNamed: 'day23-input.txt'.
map := Day23Map new init:
  (((file contentsOfEntireFile) splitBy: String lf)
    select: [:line | (line size) > 0]).

Transcript clear.
Transcript show: map findLongestPathWithSlopes; cr.
Transcript show: map findLongestPathIgnoringSlopes; cr.