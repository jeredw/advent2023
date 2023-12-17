file := FileStream fileNamed: 'day17-input.txt'.
map := Day17Map new init:
  (((file contentsOfEntireFile) splitBy: String lf)
    select: [:line | (line size) > 0]).

Transcript clear.
Transcript show: (map findShortestPathMinSteps: 0 maxSteps: 3); cr.
Transcript show: (map findShortestPathMinSteps: 4 maxSteps: 10); cr.