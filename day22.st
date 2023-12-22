file := FileStream fileNamed: 'day22-input.txt'.
jenga := Day22Jenga new init.
[file atEnd] whileFalse: [
	line := file nextLine.
	ends := line findTokens: '~'.
	p1 := Day22Point3 fromString: (ends at: 1).
	p2 := Day22Point3 fromString: (ends at: 2).
	jenga addBrick: (Day22Brick p1: p1 p2: p2).
].

Transcript clear.
Transcript show: jenga countSuperfluousBricks; cr.