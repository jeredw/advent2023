'From Squeak6.0 of 5 July 2022 [latest update: #22104] on 8 December 2023 at 10:16 pm'!
Object subclass: #Day8Network
	instanceVariableNames: 'edges'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!Day8Network methodsFor: 'as yet unclassified' stamp: 'jaw 12/8/2023 17:01'!
addNode: node left: left right: right
	edges at: node put: {left . right}.! !

!Day8Network methodsFor: 'as yet unclassified' stamp: 'jaw 12/8/2023 22:09'!
countStepsFromNode: start along: path
	| pos step numSteps |
	pos := start.
	step := 1.
	numSteps := 0.
	[(pos at: (pos size)) = $Z] whileFalse: [
		pos := self nextNode: pos dir: (path at: step).
		step := step + 1.
		step > (path size) ifTrue: [step := 1].
		numSteps := numSteps + 1.
	].
	^ numSteps! !

!Day8Network methodsFor: 'as yet unclassified' stamp: 'jaw 12/8/2023 17:02'!
edges
	^ edges.! !

!Day8Network methodsFor: 'as yet unclassified' stamp: 'jaw 12/8/2023 17:00'!
init
	edges := Dictionary new.! !

!Day8Network methodsFor: 'as yet unclassified' stamp: 'jaw 12/8/2023 17:17'!
leftOf: node
	| neighbors |
	neighbors := edges at: node ifAbsent: [self halt].
	^neighbors at: 1.! !

!Day8Network methodsFor: 'as yet unclassified' stamp: 'jaw 12/8/2023 17:42'!
nextNode: node dir: dir
	dir = $L ifTrue: [^self leftOf: node]
		ifFalse: [^self rightOf: node].! !

!Day8Network methodsFor: 'as yet unclassified' stamp: 'jaw 12/8/2023 17:17'!
rightOf: node
	| neighbors |
	neighbors := edges at: node ifAbsent: [self halt].
	^neighbors at: 2.! !

!Day8Network methodsFor: 'as yet unclassified' stamp: 'jaw 12/8/2023 17:38'!
starts
	^ (self edges keys) select: [:k | (k at: (k size)) = $A]! !
