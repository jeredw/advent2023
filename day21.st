file := FileStream fileNamed: 'day21-input.txt'.
garden := Day21Garden new init:
  (((file contentsOfEntireFile) splitBy: String lf)
    select: [:line | (line size) > 0]).

Transcript clear.
Transcript show: (garden countReachablePlots: 64); cr.
fit := [:x | ((15281 * (x**2)) + (15440 * x) + 3896)].
"0 to: 5 do: [:i | |steps reachable|
	steps := (131 * i) + 65.
	reachable := garden countReachablePlots: steps.
	Transcript show: i; show: ' '; show: reachable; show: ' '; show: (fit value: i); cr.
]."
Transcript show: (fit value: (26501365 - 65) / 131); cr.