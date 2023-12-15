'From Squeak6.0 of 5 July 2022 [latest update: #22104] on 14 December 2023 at 8:08:51 pm'!
Object subclass: #Day14Platform
	instanceVariableNames: 'matrix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!Day14Platform methodsFor: 'as yet unclassified' stamp: 'jaw 12/14/2023 20:00'!
countLoad
	|load|
	load := 0.
	1 to: (matrix rowCount) do: [:j |
		1 to: (matrix columnCount) do: [:i |
			(matrix at: j at: i) = $O ifTrue: [
				load := load + ((matrix rowCount) - j) + 1.
			].
		].
	].
	^load.! !

!Day14Platform methodsFor: 'as yet unclassified' stamp: 'jaw 12/14/2023 20:00'!
cycle
	1 to: 4 do: [:t |
		self tiltNorth.

		matrix := Matrix
			rows: (matrix columnCount)
			columns: (matrix rowCount)
			tabulate: [:j :i | matrix at: ((matrix rowCount) + 1) - i at: j].
	].! !

!Day14Platform methodsFor: 'as yet unclassified' stamp: 'jaw 12/14/2023 20:00'!
cycleOnce
	1 to: 4 do: [:t |
		self tiltNorth.

		matrix := Matrix
			rows: (matrix columnCount)
			columns: (matrix rowCount)
			tabulate: [:j :i | matrix at: ((matrix rowCount) + 1) - i at: j].
	].! !

!Day14Platform methodsFor: 'as yet unclassified' stamp: 'jaw 12/14/2023 20:00'!
cycleTimes: times
	|n history|
	n := times.
	history := OrderedCollection new.
	[n > 0] whileTrue: [
		self cycle.
		(history includes: matrix) ifFalse: [
			history add: (matrix copy).
			n := n - 1.
		] ifTrue: [ |start len|
			Transcript show: (history size); cr.
			start := history indexOf: matrix.
			len := ((history size) + 1) - start.
			n := n - 1.
			matrix := history at: (start + (n \\ len)).
			n := 0.
		].
	].
	^self countLoad! !

!Day14Platform methodsFor: 'as yet unclassified' stamp: 'jaw 12/14/2023 20:00'!
init: lines
	matrix := Matrix rows: (lines size) columns: ((lines at: 1) size).
	1 to: (lines size) do: [:y | matrix atRow: y put: (lines at: y)].! !

!Day14Platform methodsFor: 'as yet unclassified' stamp: 'jaw 12/14/2023 20:00'!
rollNorthFromRow: j column: i
	|ch|
	ch := matrix at: j at: i.
	(ch = $O) ifTrue: [
		1 to: j do: [:delta |
			(j - delta) > 0 ifTrue: [
				ch := matrix at: (j - delta) at: i.
				(ch = $.) ifFalse: [^0].
				matrix at: (j - (delta - 1)) at: i put: $..
				matrix at: (j - delta) at: i put: $O.
			].
		].
	].! !

!Day14Platform methodsFor: 'as yet unclassified' stamp: 'jaw 12/14/2023 20:00'!
show
	1 to: (matrix rowCount) do: [:j |
		1 to: (matrix columnCount) do: [:i |
			Transcript show: (matrix at: j at: i).
		].
		Transcript cr.
	].! !

!Day14Platform methodsFor: 'as yet unclassified' stamp: 'jaw 12/14/2023 20:00'!
tiltNorth
	1 to: (matrix rowCount) do: [:j |
		1 to: (matrix columnCount) do: [:i |
			self rollNorthFromRow: j column: i.
		].
	].! !
