'From Squeak6.0 of 5 July 2022 [latest update: #22104] on 19 December 2023 at 10:05:56 pm'!
Object subclass: #Day19Part
	instanceVariableNames: 'vars'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!Day19Part methodsFor: 'as yet unclassified' stamp: 'jaw 12/19/2023 22:00'!
init: line
	|s p|
	s := line copyFrom: 2 to: ((line size) - 1).	"chop off {}"
	p := s findTokens: ','.
	vars := Dictionary new.
	p do: [:kv | |t|
		t := kv splitBy: '='.
		vars at: (t at: 1) put: ((t at: 2) asInteger).
	].
	^ self! !

!Day19Part methodsFor: 'as yet unclassified' stamp: 'jaw 12/19/2023 22:00'!
sumVars
	^ (vars values) inject: 0 into: [:a :c | a + c].! !

!Day19Part methodsFor: 'as yet unclassified' stamp: 'jaw 12/19/2023 22:00'!
vars
	^ vars! !
