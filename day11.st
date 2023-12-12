file := FileStream fileNamed: 'day11-input.txt'.
galaxies := OrderedCollection new.
"expansionRate := 1."
expansionRate := 999999.
y := 1.
width := 0.
height := 0.
[file atEnd] whileFalse: [
	line := file nextLine.
	1 to: (line size) do: [:x |
		((line at: x) = $#) ifTrue: [
			galaxies add: x@y.
			width := width max: x.
			height := height max: y.
		].
	].
	y := y + 1.
].
expand := OrderedCollection new.
dx := 0.
1 to: width do: [:x |
	column := (galaxies select: [:p | (p x) = x]) collect: [:p | p + (dx@0)].
	expand addAll: column.
	((column size) = 0) ifTrue: [dx := dx + expansionRate].
].
galaxies := expand.
expand := OrderedCollection new.
dy := 0.
1 to: height do: [:y |
	row := (galaxies select: [:p | (p y) = y]) collect: [:p | p + (0@dy)].
	expand addAll: row.
	((row size) = 0) ifTrue: [dy := dy + expansionRate].
].
galaxies := expand.
distance := 0.
1 to: (galaxies size) do: [:i |
	1 to: (galaxies) size do: [:j |
		(i < j) ifTrue: [
			delta := (galaxies at: i) - (galaxies at: j).
			distance := distance + ((delta x) abs) + ((delta y) abs).
		].
	].
].

Transcript clear.
Transcript show: distance; cr.