'From Squeak6.0 of 5 July 2022 [latest update: #22104] on 21 December 2023 at 10:50:13 pm'!
Object subclass: #Day21Garden
	instanceVariableNames: 'grid start north east south west'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!Day21Garden methodsFor: 'as yet unclassified' stamp: 'jaw 12/21/2023 22:50'!
at: p
	^ grid at: ((p y) - 1 \\ (grid rowCount) + 1)
		 at: ((p x) - 1 \\ (grid columnCount) + 1)! !

!Day21Garden methodsFor: 'as yet unclassified' stamp: 'jaw 12/21/2023 22:50'!
countReachablePlots: stepLimit
	|open scheduled visited coverage|
	open := OrderedCollection new.
	open add: {start . 0}.
	visited := Set new.
	scheduled := Set new.
	[open isEmpty] whileFalse: [ |n p steps|
		n := open removeFirst. p := n at: 1. steps := n at: 2.
		visited add: p.
		steps < stepLimit ifTrue: [
			{p + north . p + east . p + south . p + west} do: [:neighbor |
				(visited includes: neighbor) | (scheduled includes: neighbor) ifFalse: [ |ch|
					ch := self at: neighbor.
					ch ~= $# ifTrue: [
						open add: {neighbor . (steps + 1)}.
						scheduled add: neighbor.
					].
				].
			].
		].
	].
	coverage := (visited select: [:v | |d|
		d := (((v y) - (start y)) abs) + (((v x) - (start x)) abs).
		(d \\ 2) == (stepLimit \\ 2)
	]).
	^ (coverage size)! !

!Day21Garden methodsFor: 'as yet unclassified' stamp: 'jaw 12/21/2023 22:50'!
init: lines
	grid := Matrix
		rows: (lines size)
		columns: ((lines at: 1) size)
		tabulate: [:j :i | (lines at: j) at: i].
	start := grid indexOf: $S.
	north := 0@(-1).
	east := 1@0.
	south := 0@1.
	west := (-1)@0.! !
