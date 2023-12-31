getCountOfColor := [:color :trial |
	matches := trial allRegexMatches: ('\d+ ', color).
	(matches size) > 0
		ifTrue: [(matches at: 1) asInteger]
		ifFalse: [0]].

parseTrial := [:trial |
	#('red' 'green' 'blue') collect: [:color |
		getCountOfColor value: color value: trial]].

gameNumberIfPossible := [:line :red :green :blue |
	game := line splitBy: ': '.
	number := (((game at: 1)
		allRegexMatches: '\d+') at: 1)
		asInteger.
	trials := (game at: 2) splitBy: '; '.
	possible := trials allSatisfy: [:t |
		count := parseTrial value: t.
		((count at: 1) <= red) &
		((count at: 2) <= green) &
		((count at: 3) <= blue).].
	possible ifTrue:[number] ifFalse:[0]].

cubePower := [:line |
	game := line splitBy: ': '.
	trials := (game at: 2) splitBy: '; '.
	red := 0.
	green := 0.
	blue := 0.
	trials do: [:t |
		count := parseTrial value: t.
		red := red max: (count  at: 1).
		green := green max: (count at: 2).
		blue := blue max: (count at: 3)].
	red * green * blue].

file := FileStream fileNamed: 'day2-input.txt'.
red := 12.
green := 13.
blue := 14.
sum := 0.
sum2 := 0.
[file atEnd] whileFalse:
	[line := file nextLine.
	 gameValue := gameNumberIfPossible value: line value: red value: green value: blue.
	 power := cubePower value: line.
	 sum := sum + gameValue.
	sum2 := sum2 + power].
Transcript clear.
Transcript show: sum; cr.
Transcript show: sum2; cr.