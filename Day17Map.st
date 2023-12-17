'From Squeak6.0 of 5 July 2022 [latest update: #22104] on 17 December 2023 at 12:51:28 pm'!
Object subclass: #Day17Map
	instanceVariableNames: 'grid'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!Day17Map methodsFor: 'as yet unclassified' stamp: 'jaw 12/17/2023 12:50'!
findShortestPathMinSteps: minSteps maxSteps: maxSteps
	|best open goal infinity|
	infinity := 1000000000.
	goal := (grid columnCount)@(grid rowCount).
	best := Dictionary new.
	open := Heap new.
	open add: (Day17PartialPath new
		initCost: 0
		position: 1@1
		heading: 1@0
		stepsInDirection: 0
	).
	[(open size) > 0] whileTrue: [ |p|
		p := open removeFirst.

		((p position) = goal) & ((p stepsInDirection) >= minSteps) ifTrue: [
			^ (p cost)
		].
		(p neighbors: grid minSteps: minSteps maxSteps: maxSteps) do: [:n | |k|
			k := best at: (n key) ifAbsent: [infinity].
			(n cost) < k ifTrue: [
				best at: (n key) put: (n cost).
				open add: n.
			].
		].
	].
	^ infinity! !

!Day17Map methodsFor: 'as yet unclassified' stamp: 'jaw 12/17/2023 12:50'!
init: lines
	grid := Matrix
		rows: (lines size)
		columns: ((lines at: 1) size)
		tabulate: [:j :i | ((lines at: j) at: i) digitValue].! !
