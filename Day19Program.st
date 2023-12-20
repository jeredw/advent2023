'From Squeak6.0 of 5 July 2022 [latest update: #22104] on 19 December 2023 at 10:05:58 pm'!
Object subclass: #Day19Program
	instanceVariableNames: 'workflows'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!Day19Program methodsFor: 'as yet unclassified' stamp: 'jaw 12/19/2023 22:00'!
accept: part
	|flow|
	flow := 'in'.
	[(flow ~= 'A') & (flow ~= 'R')] whileTrue: [
		flow := (workflows at: flow) applyTo: part.
	].
	^ flow = 'A'! !

!Day19Program methodsFor: 'as yet unclassified' stamp: 'jaw 12/19/2023 22:00'!
count: xs
	|ranges|
	ranges := Dictionary new.
	ranges at: 'x' put: xs.
	ranges at: 'm' put: xs.
	ranges at: 'a' put: xs.
	ranges at: 's' put: xs.
	^self count: 'in' ranges: ranges
	! !

!Day19Program methodsFor: 'as yet unclassified' stamp: 'jaw 12/19/2023 22:00'!
count: flow ranges: ranges
	((ranges values) anySatisfy: [:r | (r size) = 0]) ifTrue: [^0].
	(flow = 'R') ifTrue: [^0].
	(flow = 'A') ifTrue: [^((ranges values) inject: 1 into: [:a :c | a * (c size)])].
	^(workflows at: flow) count: self ranges: ranges! !

!Day19Program methodsFor: 'as yet unclassified' stamp: 'jaw 12/19/2023 22:00'!
init: w
	workflows := w! !
