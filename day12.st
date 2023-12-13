file := FileStream fileNamed: 'day12-input.txt'.
answer1 := 0.
answer2 := 0.
[file atEnd] whileFalse: [
	input := (file nextLine) splitBy: ' '.
	string := input at: 1.
	constraints := ((input at: 2) findTokens: ',') collect: [:n | n asInteger].
	counter := Day12Counter new initString: string constraints: constraints.
	answer1 := answer1 + (counter countMatches).
	"part 2"
	bigString := string, '?', string, '?', string, '?', string, '?', string.
	bigConstraints := OrderedCollection new.
	5 timesRepeat: [bigConstraints addAll: constraints].
	bigCounter := Day12Counter new initString: bigString constraints: bigConstraints.
	answer2 := answer2 + (bigCounter countMatches).
].

Transcript clear.
Transcript show: answer1; cr.
Transcript show: answer2; cr.