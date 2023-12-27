file := FileStream fileNamed: 'day25-input.txt'.
graph := Day25Graph new.
[file atEnd] whileFalse: [ |p u vs|
	line := file nextLine.
	p := line splitBy: ': '.
	u := p at: 1.
	vs := (p at: 2) splitBy: ' '.
	vs do: [:v | graph addEdgeBetween: u and: v].
].

Transcript clear.
Transcript show: graph minCut; cr.
