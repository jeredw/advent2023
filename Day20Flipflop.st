'From Squeak6.0 of 5 July 2022 [latest update: #22104] on 20 December 2023 at 4:44:07 pm'!
Object subclass: #Day20Flipflop
	instanceVariableNames: 'name outputs state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!Day20Flipflop methodsFor: 'as yet unclassified' stamp: 'jaw 12/20/2023 16:40'!
addInput: input! !

!Day20Flipflop methodsFor: 'as yet unclassified' stamp: 'jaw 12/20/2023 16:40'!
init: nameValue outputs: outputsValue
	name := nameValue.
	outputs := outputsValue.
	state := false.! !

!Day20Flipflop methodsFor: 'as yet unclassified' stamp: 'jaw 12/20/2023 16:40'!
outputs
	^ outputs! !

!Day20Flipflop methodsFor: 'as yet unclassified' stamp: 'jaw 12/20/2023 16:40'!
send: pulse from: from circuit: circuit
	pulse ifFalse: [
		state := state not.
		outputs do: [:output | circuit send: state from: name to: output].
	].! !
