'From Squeak6.0 of 20 December 2023 [latest update: #22147] on 23 December 2023 at 2:38:18 pm'!
Object subclass: #Day23PartialPath
	instanceVariableNames: 'position steps visited'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!Day23PartialPath methodsFor: 'as yet unclassified' stamp: 'jaw 12/23/2023 14:35'!
extendTo: neighbor distance: distance
	^ Day23PartialPath new position: neighbor
		steps: steps + distance
		visited: (visited copy add: neighbor; yourself).! !

!Day23PartialPath methodsFor: 'as yet unclassified' stamp: 'jaw 12/23/2023 14:18'!
position
	^ position! !

!Day23PartialPath methodsFor: 'as yet unclassified' stamp: 'jaw 12/23/2023 14:18'!
position: t1 steps: t2 visited: t3
	position := t1.
	steps := t2.
	visited := t3.! !

!Day23PartialPath methodsFor: 'as yet unclassified' stamp: 'jaw 12/23/2023 14:18'!
steps
	^ steps! !

!Day23PartialPath methodsFor: 'as yet unclassified' stamp: 'jaw 12/23/2023 14:18'!
visited
	^ visited! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Day23PartialPath class
	instanceVariableNames: ''!

!Day23PartialPath class methodsFor: 'as yet unclassified' stamp: 'jaw 12/23/2023 14:21'!
startingAt: start
	^ self new position: start
		steps: 0
		visited: (Set with: start).! !
