file := FileStream fileNamed: 'day9-input.txt'.
answer1 := 0.
answer2 := 0.
[file atEnd] whileFalse: [
	line := file nextLine.
	seq := (line findTokens: ' ') collect: [:n | n asInteger].
	tri := OrderedCollection new.
	[seq allSatisfy: [:n | n = 0]] whileFalse: [
		tri add: seq beforeIndex: 1.
		deltas := seq overlappingPairsCollect: [:a :b | b - a].
		seq := deltas.
	].
	next := tri inject: 0 into: [:a :c | a + (c last)].
	prev := tri inject: 0 into: [:a :c | (c first) - a].
	answer1 := answer1 + next.
	answer2 := answer2 + prev.
].

Transcript clear.
Transcript show: answer1; cr.
Transcript show: answer2; cr.