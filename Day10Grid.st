'From Squeak6.0 of 5 July 2022 [latest update: #22104] on 10 December 2023 at 2:51:47 pm'!
Object subclass: #Day10Grid
	instanceVariableNames: 'grid width height start atStart north south east west'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!Day10Grid methodsFor: 'as yet unclassified' stamp: 'jaw 12/10/2023 14:30'!
at: p
	(p = start) ifTrue: [^ atStart].
	(self inBounds: p) ifFalse: [^ $.]
		ifTrue: [^ (grid at: (p y)) at: (p x)].! !

!Day10Grid methodsFor: 'as yet unclassified' stamp: 'jaw 12/10/2023 14:30'!
findLoop
	|p prev looped loop|
	p := start.
	prev := 0@0.
	looped := false.
	loop := Set new.
	[looped] whileFalse: [|next|
		loop add: p.
		next := ((self neighbors: p) reject: [:n | n = prev]) first.
		prev := p.
		p := next.
		looped := p = start.
	].
	^ loop! !

!Day10Grid methodsFor: 'as yet unclassified' stamp: 'jaw 12/10/2023 14:30'!
findStart
	1 to: (grid size) do: [:y | |x|
		x := (grid at: y) indexOf: $S.
		x > 0 ifTrue: [^ x@y].
	].
	^ 0@0.! !

!Day10Grid methodsFor: 'as yet unclassified' stamp: 'jaw 12/10/2023 14:30'!
inBounds: p
	^ (((p x) < 1) | ((p x) > width) | ((p y) < 1) | ((p y) > height)) not.! !

!Day10Grid methodsFor: 'as yet unclassified' stamp: 'jaw 12/10/2023 14:30'!
init: lines
	grid := lines select: [:x | (x size) > 0].
	width := (grid at: 1) size.
	height := grid size.
	north := (0@(-1)).
	south := (0@1).
	east := (1@0).
	west := ((-1)@0).
	self initStart.! !

!Day10Grid methodsFor: 'as yet unclassified' stamp: 'jaw 12/10/2023 14:30'!
initStart
	|conn n e s w|
	n := #(1 0 0 0). e := #(0 1 0 0). s := #(0 0 1 0). w := #(0 0 0 1).
	start := self findStart.
	conn := {(start + north) . (start + east) . (start + south) . (start + west)} collect: [:p |
		((self neighbors: p) includes: start) asInteger
	].
	atStart := $ .
	(conn = (n + s)) ifTrue: [atStart := $|].
	(conn = (e + w)) ifTrue: [atStart := $-].
	(conn = (n + e)) ifTrue: [atStart := $L].
	(conn = (n + w)) ifTrue: [atStart := $J].
	(conn = (s + w)) ifTrue: [atStart := $7].
	(conn = (s + e)) ifTrue: [atStart := $F].! !

!Day10Grid methodsFor: 'as yet unclassified' stamp: 'jaw 12/10/2023 14:30'!
loopArea
	|loop count|
	loop := self findLoop.
	count := 0.
	1 to: height do: [:y | |parity prevCorner|
		parity := 0.
		prevCorner := $/.
		1 to: width do: [:x | |c|
			c := self at: x@y.
			(loop includes: (x@y)) ifTrue: [
				(c = $|) ifTrue: [parity := parity + 1].
				('F7LJ' includes: c) ifTrue: [
					($/ = prevCorner) ifFalse: [
						((prevCorner = $F) & (c = $J)) ifTrue: [parity := parity + 1].
						((prevCorner = $L) & (c = $7)) ifTrue: [parity := parity + 1].
						prevCorner := $/.
					] ifTrue: [
						prevCorner := c.
					].
				].
			] ifFalse: [
				(parity odd) ifTrue: [count := count + 1].
			].
		].
	].
	^ count! !

!Day10Grid methodsFor: 'as yet unclassified' stamp: 'jaw 12/10/2023 14:30'!
loopSemiPerimeter
	^ ((self findLoop) size) // 2! !

!Day10Grid methodsFor: 'as yet unclassified' stamp: 'jaw 12/10/2023 14:30'!
neighbors: p
	|n e s w tile|
	n := p + north.
	e := p + east.
	s := p + south.
	w := p + west.
	tile := self at: p.
	tile = $| ifTrue: [^ {n . s}].
	tile = $- ifTrue: [^ {w . e}].
	tile = $L ifTrue: [^ {n . e}].
	tile = $J ifTrue: [^ {n . w}].
	tile = $7 ifTrue: [^ {s . w}].
	tile = $F ifTrue: [^ {s . e}].
	^ #().! !
