'From Squeak6.0 of 5 July 2022 [latest update: #22104] on 20 December 2023 at 4:44:05 pm'!
Object subclass: #Day20Conjunction
	instanceVariableNames: 'name monitor outputs state pushes pushesWhenLastTrue periods'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!Day20Conjunction methodsFor: 'as yet unclassified' stamp: 'jaw 12/20/2023 16:40'!
addInput: input
	state at: input put: false.
	periods at: input put: 0.! !

!Day20Conjunction methodsFor: 'as yet unclassified' stamp: 'jaw 12/20/2023 16:40'!
init: nameValue outputs: outputsValue
	name := nameValue.
	outputs := outputsValue.
	state := Dictionary new.
	monitor := false.
	pushesWhenLastTrue := Dictionary new.
	periods := Dictionary new.
	pushes := 0.! !

!Day20Conjunction methodsFor: 'as yet unclassified' stamp: 'jaw 12/20/2023 16:40'!
outputs
	^ outputs! !

!Day20Conjunction methodsFor: 'as yet unclassified' stamp: 'jaw 12/20/2023 16:40'!
periods
	^ periods! !

!Day20Conjunction methodsFor: 'as yet unclassified' stamp: 'jaw 12/20/2023 16:40'!
send: pulse from: from circuit: circuit
	|anyInputFalse|
	state at: from put: pulse.
	monitor ifTrue: [self updatePeriods].
	anyInputFalse := ((state values) anySatisfy: [:s | s = false]).
	outputs do: [:output | circuit send: anyInputFalse from: name to: output].! !

!Day20Conjunction methodsFor: 'as yet unclassified' stamp: 'jaw 12/20/2023 16:40'!
setPushes: t
	pushes := t! !

!Day20Conjunction methodsFor: 'as yet unclassified' stamp: 'jaw 12/20/2023 16:40'!
startMonitoring
	monitor := true.! !

!Day20Conjunction methodsFor: 'as yet unclassified' stamp: 'jaw 12/20/2023 16:40'!
updatePeriods
	state keysAndValuesDo: [:input :inputState |
		inputState ifTrue: [
			(pushesWhenLastTrue includesKey: input) ifTrue: [ |p|
				p := pushesWhenLastTrue at: input ifAbsent: [0].
				periods at: input put: (pushes - p).
			] ifFalse: [
				pushesWhenLastTrue at: input put: pushes.
			]. 
		].
	].! !
