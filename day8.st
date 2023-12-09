"read in the graph"
network := Day8Network new init.
file := FileStream fileNamed: 'day8-input.txt'.
path := file nextLine.
file nextLine.
[file atEnd] whileFalse: [
	nodes := ((file nextLine) select: [:c | (c isAlphaNumeric) | (c = $ )]) findTokens: $ .
	network addNode: (nodes at: 1) left: (nodes at: 2) right: (nodes at: 3).
].

"count steps. luckily, all paths cycle after the single unique end"
answer1 := network countStepsFromNode: 'AAA' along: path.
answer2 := 1.
(network starts) do: [:node |
	steps := network countStepsFromNode: node along: path.
	answer2 := answer2 lcm: steps.
].

Transcript clear.
Transcript show: answer1; cr.
Transcript show: answer2; cr.
