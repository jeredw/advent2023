file := FileStream fileNamed: 'day25-input.txt'.
graph := Dictionary new.
[file atEnd] whileFalse: [
	line := file nextLine.
	p := line splitBy: ': '.
	u := p at: 1.
	vs := (p at: 2) splitBy: ' '.
	vs do: [:v |
		edges := graph at: u ifAbsent: [Set new].
		edges add: v.
		graph at: u put: edges.
		edges := graph at: v ifAbsent: [Set new].
		edges add: u.
		graph at: v put: edges.
	].
].

"from inspection of dot output"
{'fbd'->'lzd' . 'fxn'->'ptq' . 'kcn'->'szl'} do: [:e |
	(graph at: (e key)) remove: (e value).
	(graph at: (e value)) remove: (e key).
].

search := [:v | |visited|
	open := OrderedCollection with: v.
	visited := Set new.
	[open isEmpty] whileFalse: [|cv|
		cv := open removeFirst.
		visited add: cv.
		(graph at: cv) do: [:n |
			(visited includes: n) ifFalse: [
				open add: n.
			].
		].
	].
	(visited size)
].

component1Size := search value: 'fbd'.
component2Size := search value: 'lzd'.
Transcript clear.
Transcript show: component1Size; show: ' '; show: component2Size; show: ' '; show: (component1Size * component2Size); cr.