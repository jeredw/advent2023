'From Squeak6.0 of 20 December 2023 [latest update: #22147] on 23 December 2023 at 2:38:14 pm'!
Object subclass: #Day23Map
	instanceVariableNames: 'grid start goal vertices edges'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!Day23Map methodsFor: 'as yet unclassified' stamp: 'jaw 12/23/2023 14:36'!
extractGraph
	vertices := OrderedCollection with: start with: goal.
	grid withIndicesDo: [:ch :y :x |
		ch = $. ifTrue: [ |openNeighbors|
			openNeighbors := (x@y) fourNeighbors select: [:p |
				(grid at: (p y) at: (p x) ifInvalid: $#) ~= $#].
			openNeighbors size > 2 ifTrue: [
				vertices add: x@y.
			].
		].
	].
	edges := Dictionary new.
	vertices combinations: 2 atATimeDo: [:uv | |u v distance| u := uv at: 1. v := uv at: 2.
		distance := self searchGridAt: u
			target: v
			path: (vertices asSet remove: v; yourself)
			steps: 0
			best: 0
			ignoreSlopes: true.
		distance > 0 ifTrue: [ |neighbors|
			neighbors := edges at: u ifAbsent: [Dictionary new].
			neighbors at: v put: distance.
			edges at: u put: neighbors.
			neighbors := edges at: v ifAbsent: [Dictionary new].
			neighbors at: u put: distance.
			edges at: v put: neighbors.
		].
	].! !

!Day23Map methodsFor: 'as yet unclassified' stamp: 'jaw 12/23/2023 14:36'!
findLongestPathIgnoringSlopes
	|open best|
	self extractGraph.
	open := OrderedCollection with: (Day23PartialPath startingAt: start).
	best := 0.
	[open isEmpty] whileFalse: [ |p|
		p := open removeFirst.
		(p position) = goal ifTrue: [
			best := (p steps) max: best
		] ifFalse: [
			(edges at: (p position)) keysAndValuesDo: [:neighbor :distance |
				(p visited includes: neighbor) ifFalse: [
					open add: (p extendTo: neighbor distance: distance).
				].
			].
		].
	].
	^ best! !

!Day23Map methodsFor: 'as yet unclassified' stamp: 'jaw 12/23/2023 14:34'!
findLongestPathWithSlopes
	^ self searchGridAt: start
		target: goal
		path: Set new
		steps: 0
		best: 0
		ignoreSlopes: false.! !

!Day23Map methodsFor: 'as yet unclassified' stamp: 'jaw 12/23/2023 14:33'!
init: lines
	grid := Matrix
		rows: lines size
		columns: (lines at: 1) size
		tabulate: [:j :i | (lines at: j) at: i].
	start := ((grid atRow: 1) indexOf: $.)@1.
	goal := ((grid atRow: grid rowCount) indexOf: $.)@grid rowCount.! !

!Day23Map methodsFor: 'as yet unclassified' stamp: 'jaw 12/23/2023 14:37'!
searchGridAt: position target: target path: path steps: steps best: best ignoreSlopes: ignoreSlopes
	|ch next nextBest|
	position = target ifTrue: [^ steps max: best].
	ch := grid at: position y at: position x.
	next := true caseOf: {
		[ignoreSlopes | (ch = $.)] -> [position fourNeighbors].
		[ch = $^] -> [Array with: (position + (0 @ -1))].
		[ch = $>] -> [Array with: (position + (1 @ 0))].
		[ch = $v] -> [Array with: (position + (0 @ 1))].
		[ch = $<] -> [Array with: (position + (-1 @ 0))]
	}.
	next := next select: [:p | ((grid at: p y at: p x ifInvalid: $#) ~= $#) &
								((path includes: p) not)].
	nextBest := best.
	next do: [:p | |bestHere|
		path add: position.
		bestHere := self searchGridAt: p
			target: target
			path: path
			steps: steps + 1
			best: nextBest
			ignoreSlopes: ignoreSlopes.
		path remove: position.
		nextBest := nextBest max: bestHere.
	].
	^ nextBest
! !
