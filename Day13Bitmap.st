'From Squeak6.0 of 5 July 2022 [latest update: #22104] on 13 December 2023 at 11:09:40 pm'!
Object subclass: #Day13Bitmap
	instanceVariableNames: 'matrix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!Day13Bitmap methodsFor: 'as yet unclassified' stamp: 'jaw 12/13/2023 23:00'!
findFirstMirror: m skip: y
	1 to: ((m rowCount) - 1) do: [:y0 |
		(y0 ~= y) ifTrue: [
			(self isMirrored: m across: y0) ifTrue: [^y0]
		]
	].
	^0! !

!Day13Bitmap methodsFor: 'as yet unclassified' stamp: 'jaw 12/13/2023 23:00'!
findMirrors: skip
	|up left|
	up := self findFirstMirror: matrix skip: (skip at: 1).
	left := self findFirstMirror: (matrix transposed) skip: (skip at: 2).
	^{up . left}! !

!Day13Bitmap methodsFor: 'as yet unclassified' stamp: 'jaw 12/13/2023 23:00'!
init: lines
	matrix := Matrix rows: (lines size) columns: ((lines at: 1) size).
	1 to: (lines size) do: [:y | matrix atRow: y put: (lines at: y)].! !

!Day13Bitmap methodsFor: 'as yet unclassified' stamp: 'jaw 12/13/2023 23:00'!
isMirrored: m across: y0
	1 to: (m rowCount) do: [:i | |upper lower|
		upper := y0 - (i - 1).
		lower := y0 + i.
		((upper < 1) | (lower > (m rowCount))) ifTrue: [^true].
		((m atRow: upper) = (m atRow: lower)) ifFalse: [^false].
	].
	^true! !

!Day13Bitmap methodsFor: 'as yet unclassified' stamp: 'jaw 12/13/2023 23:00'!
scoreMirrors
	|mirrors|
	mirrors := self findMirrors: #(0 0).
	^(100 * (mirrors at: 1)) + (mirrors at: 2)! !

!Day13Bitmap methodsFor: 'as yet unclassified' stamp: 'jaw 12/13/2023 23:00'!
scoreMirrorsSmudge
	|skip|
	skip := self findMirrors: #(0 0).
	1 to: (matrix rowCount) do: [:j |
		1 to: (matrix columnCount) do: [:i | |ch mirrors|
			ch := matrix at: j at: i.
			ch = $. ifTrue: [matrix at: j at: i put: $#].
			ch = $# ifTrue: [matrix at: j at: i put: $.].
			mirrors := self findMirrors: skip.
			matrix at: j at: i put: ch.
			(mirrors ~= #(0 0)) ifTrue: [^(100 * (mirrors at: 1)) + (mirrors at: 2)].
		].
	].
	self halt.
	^0! !
