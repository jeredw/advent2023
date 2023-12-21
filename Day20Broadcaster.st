'From Squeak6.0 of 5 July 2022 [latest update: #22104] on 20 December 2023 at 4:44 pm'!
Object subclass: #Day20Broadcaster
	instanceVariableNames: 'name outputs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!Day20Broadcaster methodsFor: 'as yet unclassified' stamp: 'jaw 12/20/2023 16:40'!
addInput: input! !

!Day20Broadcaster methodsFor: 'as yet unclassified' stamp: 'jaw 12/20/2023 16:40'!
init: nameValue outputs: outputsValue
	name := nameValue.
	outputs := outputsValue.! !

!Day20Broadcaster methodsFor: 'as yet unclassified' stamp: 'jaw 12/20/2023 16:40'!
outputs
	^ outputs! !

!Day20Broadcaster methodsFor: 'as yet unclassified' stamp: 'jaw 12/20/2023 16:40'!
send: pulse from: from circuit: circuit
	outputs do: [:output | circuit send: pulse from: name to: output].! !
