'From Squeak6.0 of 5 July 2022 [latest update: #22104] on 13 December 2023 at 12:47:10 am'!
Object subclass: #Day12Counter
	instanceVariableNames: 'string constraints cache'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!Day12Counter methodsFor: 'as yet unclassified' stamp: 'jaw 12/13/2023 00:40'!
countMatches
	^ self countMatches: 1 j: 1 state: -1! !

!Day12Counter methodsFor: 'as yet unclassified' stamp: 'jaw 12/13/2023 00:40'!
countMatches: i j: j state: state
	|ch|
	(i > (string size)) ifTrue: [
		"match if at end of string and on last run"
		(state <= 0) & (j > (constraints size)) ifTrue: [^1] ifFalse: [^0].
	].
	ch := string at: i.
	(state < 0) ifTrue: [|z|	"optional ."
		(ch = $#) ifTrue: [	"start of new run"
			(j > (constraints size)) ifTrue: [^0].
			^self countMatchesMemo: i j: (j+1) state: (constraints at: j).			
		].
		z := (self countMatchesMemo: (i+1) j: j state: -1).
		((ch = $.) | (j > (constraints size))) ifTrue: [^z].
		^z + (self countMatchesMemo: i j: (j+1) state: (constraints at: j))
	].
	(state = 0) ifTrue: [	"required ."
		(ch = $#) ifTrue: [^0].
		^self countMatchesMemo: (i+1) j: j state: -1
	].
	(state > 0) ifTrue: [	"required #"
		(ch = $.) ifTrue: [^0].
		^self countMatchesMemo: (i+1) j: j state: (state-1)
	].! !

!Day12Counter methodsFor: 'as yet unclassified' stamp: 'jaw 12/13/2023 00:46'!
countMatchesMemo: i j: j state: state
	|result key|
	key := {i . j . state}.
	^cache at: key ifAbsent: [
		result := self countMatches: i j: j state: state.
		cache at: key put: result.
		^result
	].! !

!Day12Counter methodsFor: 'as yet unclassified' stamp: 'jaw 12/13/2023 00:33'!
initString: s constraints: c
	string := s.
	constraints := c.
	cache := Dictionary new.! !
