file := FileStream fileNamed: 'day18-input.txt'.
map := (Day18Dig new) init.
bigMap := (Day18Dig new) init.
[file atEnd] whileFalse: [
	line := (file nextLine) findTokens: ' '.
	direction := line at: 1.
	steps := (line at: 2) asInteger.
	map dig: direction steps: steps.
	color := (line at: 3) copyFrom: 2 to: 8.
	((color last) = $0) ifTrue: [bigDirection := 'R'].
	((color last) = $1) ifTrue: [bigDirection := 'D'].
	((color last) = $2) ifTrue: [bigDirection := 'L'].
	((color last) = $3) ifTrue: [bigDirection := 'U'].
	bigSteps := Integer readFrom: (color copyFrom: 2 to: 6) base: 16.
	bigMap dig: bigDirection steps: bigSteps.
].

Transcript clear.
Transcript show: (map area); cr.
Transcript show: (bigMap area); cr.