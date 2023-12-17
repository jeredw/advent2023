'From Squeak6.0 of 5 July 2022 [latest update: #22104] on 17 December 2023 at 12:51:31 pm'!
Object subclass: #Day17PartialPath
	instanceVariableNames: 'cost position heading stepsInDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!Day17PartialPath methodsFor: 'as yet unclassified' stamp: 'jaw 12/17/2023 12:50'!
<= other
	^ (self cost) <= (other cost)! !

!Day17PartialPath methodsFor: 'as yet unclassified' stamp: 'jaw 12/17/2023 12:50'!
cost
	^ cost! !

!Day17PartialPath methodsFor: 'as yet unclassified' stamp: 'jaw 12/17/2023 12:50'!
initCost: t1 position: t2 heading: t3 stepsInDirection: t4
	cost := t1.
	position := t2.
	heading := t3.
	stepsInDirection := t4.! !

!Day17PartialPath methodsFor: 'as yet unclassified' stamp: 'jaw 12/17/2023 12:50'!
isValidDirection: dir grid: grid minSteps: minSteps maxSteps: maxSteps
	|p|
	p := position + dir.
	(((p x) between: 1 and: (grid columnCount)) & ((p y) between: 1 and: (grid rowCount))) ifTrue: [
		(stepsInDirection < minSteps) ifTrue: [^heading = dir].
		(stepsInDirection >= maxSteps) ifTrue: [^heading ~= dir].
		^true.
	].
	^false! !

!Day17PartialPath methodsFor: 'as yet unclassified' stamp: 'jaw 12/17/2023 12:50'!
key
	^{position . heading . stepsInDirection}! !

!Day17PartialPath methodsFor: 'as yet unclassified' stamp: 'jaw 12/17/2023 12:50'!
neighbors: grid minSteps: minSteps maxSteps: maxSteps
	|result consider|
	result := OrderedCollection new.
	consider := [:dir |
		(self isValidDirection: dir grid: grid minSteps: minSteps maxSteps: maxSteps) ifTrue: [ |p|
			p := position + dir.
			result add: (Day17PartialPath new
				initCost: cost + (grid at: (p y) at: (p x))
				position: p
				heading: dir
				stepsInDirection: (heading ~= dir ifTrue: [1] ifFalse: [stepsInDirection + 1])
			).
		].
	].
	consider value: heading.
	consider value: ((heading y) negated)@(heading x).
	consider value: (heading y)@((heading x) negated).
	^ result! !

!Day17PartialPath methodsFor: 'as yet unclassified' stamp: 'jaw 12/17/2023 12:50'!
position
	^ position! !

!Day17PartialPath methodsFor: 'as yet unclassified' stamp: 'jaw 12/17/2023 12:50'!
stepsInDirection
	^ stepsInDirection! !
