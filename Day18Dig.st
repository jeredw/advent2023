'From Squeak6.0 of 5 July 2022 [latest update: #22104] on 19 December 2023 at 2:00:13 am'!
Object subclass: #Day18Dig
	instanceVariableNames: 'vertices edges corners startDir prevDir pos directions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!Day18Dig methodsFor: 'as yet unclassified' stamp: 'jaw 12/19/2023 01:58'!
area
	|sum rowSum xs ys lastY|
	sum := 0.
	rowSum := 0.
	xs := (vertices collect: [:v | (v x)]) asSet sorted.
	ys := (vertices collect: [:v | (v y)]) asSet sorted.
	lastY := ys first.
	ys do: [:y | |lastCorner parity lastX|
		sum := sum + (rowSum * (y - lastY)).
		rowSum := 0.
		parity := 0.
		lastCorner := $/.
		lastX := xs first.
		xs do: [:x | |c|
			c := self findAt: x@y.
			(c = $/) ifFalse: [
				(c = $|) ifTrue: [
					rowSum := rowSum + 1.
					(parity odd) ifTrue: [rowSum := rowSum + (x - lastX) - 1].
					parity := parity + 1
				].
				('F7LJ' includes: c) ifTrue: [
					($/ = lastCorner) ifFalse: [
						(lastCorner = $F) ifTrue: [
							(parity even) ifTrue: [
								rowSum := rowSum + (x - lastX) + 1.
							] ifFalse: [
								(c = $7) ifTrue: [
									rowSum := rowSum + 2.
									sum := sum + (x - lastX) - 1.
								] ifFalse: [
									rowSum := rowSum + 1.
									sum := sum + (x - lastX).
								].
							].
						].
						((lastCorner ~= $F) & (c = $7)) ifTrue: [
							(parity even) ifTrue: [
								sum := sum + (x - lastX).
								rowSum := rowSum + 1.
							] ifFalse: [
								rowSum := rowSum + (x - lastX) + 1.
							].
						].
						((lastCorner ~= $F) & (c ~= $7)) ifTrue: [
							(parity even) ifTrue: [
								sum := sum + (x - lastX) + 1.
							] ifFalse: [
								rowSum := rowSum + (x - lastX) + 1.
							].
						].
						((lastCorner = $F) & (c = $J)) ifTrue: [parity := parity + 1].
						((lastCorner = $L) & (c = $7)) ifTrue: [parity := parity + 1].
						lastCorner := $/.
					] ifTrue: [
						(parity odd) ifTrue: [
							rowSum := rowSum + (x - lastX) - 1.
						].
						lastCorner := c.
					].
				].
				lastX := x.
			].
		].
		lastY := y.
	].
	^ sum + rowSum.! !

!Day18Dig methodsFor: 'as yet unclassified' stamp: 'jaw 12/19/2023 01:58'!
classifyCornerIn: in out: out
	((in = 'U') & (out = 'R')) ifTrue: [^$F].
	((in = 'U') & (out = 'L')) ifTrue: [^$7].
	((in = 'D') & (out = 'R')) ifTrue: [^$L].
	((in = 'D') & (out = 'L')) ifTrue: [^$J].
	((in = 'R') & (out = 'U')) ifTrue: [^$J].
	((in = 'R') & (out = 'D')) ifTrue: [^$7].
	((in = 'L') & (out = 'U')) ifTrue: [^$L].
	((in = 'L') & (out = 'D')) ifTrue: [^$F].
	^ $/.! !

!Day18Dig methodsFor: 'as yet unclassified' stamp: 'jaw 12/19/2023 01:58'!
dig: dir steps: steps
	|nextPos corner|
	nextPos := pos + (steps * (directions at: dir)).
	vertices add: nextPos.
	corner := self classifyCornerIn: prevDir out: dir.
	(corner = $/) ifFalse: [corners at: pos put: corner].
	(pos = (0@0)) ifTrue: [startDir := dir].
	(nextPos = (0@0)) ifTrue: [
		"classify corner into start vertex"
		corner := self classifyCornerIn: dir out: startDir.
		(corner = $/) ifFalse: [corners at: nextPos put: corner].
	].
	edges add: {pos . nextPos}.
	pos := nextPos.
	prevDir := dir.! !

!Day18Dig methodsFor: 'as yet unclassified' stamp: 'jaw 12/19/2023 01:58'!
findAt: p
	^ corners at:p ifAbsent: [
		edges do: [:e | |p1 p2|
			p1 := e at: 1.
			p2 := e at: 2.
			((p1 x) = (p2 x)) & ((p x) = (p1 x)) ifTrue: [ |y0 y1|
				y0 := (p1 y) min: (p2 y).
				y1 := (p1 y) max: (p2 y).
				((p y) between: y0 and: y1) ifTrue: [^$|].
			].
		].
		$/	"no edge here"
	].! !

!Day18Dig methodsFor: 'as yet unclassified' stamp: 'jaw 12/19/2023 01:58'!
init
	directions := Dictionary new.
	directions at: 'U' put: 0@(-1).
	directions at: 'D' put: 0@1.
	directions at: 'L' put: (-1)@0.
	directions at: 'R' put: 1@0.
	pos := 0@0.
	startDir := '?'.
	prevDir := '?'.
	edges := OrderedCollection new.
	vertices := OrderedCollection new.
	corners := Dictionary new.! !
