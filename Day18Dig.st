'From Squeak6.0 of 5 July 2022 [latest update: #22104] on 19 December 2023 at 4:27:47 pm'!
Object subclass: #Day18Dig
	instanceVariableNames: 'vertices edges corners startDir prevDir pos directions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!Day18Dig methodsFor: 'as yet unclassified' stamp: 'jaw 12/19/2023 16:26'!
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
		xs do: [:x | |c span|
			c := self findAt: x@y.
			span := x - lastX. "(lastX, x]"
			(c = $/) ifFalse: [
				(c = $|) ifTrue: [
					(parity odd) ifTrue: [	"....|, left inside"
						rowSum := rowSum + span - 1	"fill left"
					].
					rowSum := rowSum + 1.	"fill beneath |"
					parity := parity + 1
				].
				('F7LJ' includes: c) ifTrue: [
					($/ = lastCorner) ifTrue: [
						(parity odd) ifTrue: [	"....C, left inside"
							rowSum := rowSum + span - 1	"fill left"
						].
						lastCorner := c.
					] ifFalse: [
						(lastCorner = $F) & (c = $7) ifTrue: [
							(parity even) ifTrue: [	"F---7, left outside"
								rowSum := rowSum + span + 1.	"fill beneath edge"
							] ifFalse: [	"F---7, left inside"
								rowSum := rowSum + 2.	"fill beneath corners"
								sum := sum + span - 1.	"fill boundary (this row)"
							].
						].
						(lastCorner = $F) & (c = $J) ifTrue: [
							(parity even) ifTrue: [	"F---J, left outside"
								rowSum := rowSum + span + 1.	"fill beneath edge"
							] ifFalse: [	"F---J, left inside"
								rowSum := rowSum + 1.	"fill beneath F"
								sum := sum + span.		"fill boundary (this row)"
							].
							parity := parity + 1.
						].
						((lastCorner = $L) & (c = $7)) ifTrue: [
							(parity even) ifTrue: [	"L---7, left outside"
								rowSum := rowSum + 1.	"fill beneath 7"
								sum := sum + span.	"fill boundary (this row)"
							] ifFalse: [	"L---7, left inside"
								rowSum := rowSum + span + 1.	"fill beneath edge"
							].
							parity := parity + 1.
						].
						((lastCorner = $L) & (c = $J)) ifTrue: [
							(parity even) ifTrue: [	"L---J, left ouside"
								sum := sum + span + 1.	"fill boundary (this row)"
							] ifFalse: [	"L---J, left inside"
								rowSum := rowSum + span + 1.	"fill beneath edge"
							].
						].
						lastCorner := $/.
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
