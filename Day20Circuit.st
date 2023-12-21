'From Squeak6.0 of 5 July 2022 [latest update: #22104] on 20 December 2023 at 4:44:03 pm'!
Object subclass: #Day20Circuit
	instanceVariableNames: 'modules queue highPulses lowPulses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!Day20Circuit methodsFor: 'as yet unclassified' stamp: 'jaw 12/20/2023 16:40'!
init
	modules := Dictionary new.
	queue := OrderedCollection new.
	highPulses := 0.
	lowPulses := 0.! !

!Day20Circuit methodsFor: 'as yet unclassified' stamp: 'jaw 12/20/2023 16:40'!
parseAndAdd: line
	|p kind name outputs module|
	p := line splitBy: ' -> '.
	kind := (p at: 1) at: 1.
	name := (p at: 1) copyFrom: 2 to: ((p at: 1) size).
	outputs := (p at: 2) splitBy: ', '.
	(kind = $&) ifTrue: [module := Day20Conjunction new init: name outputs: outputs].
	(kind = $%) ifTrue: [module := Day20Flipflop new init: name outputs: outputs].
	(kind = $b) ifTrue: [
		name := (p at: 1).
		module := Day20Broadcaster new init: name outputs: outputs
	].
	modules at: name put: module.
	self updateInputs.! !

!Day20Circuit methodsFor: 'as yet unclassified' stamp: 'jaw 12/20/2023 16:40'!
pushButton
	self send: false from: 'button' to: 'broadcaster'.
	[queue isEmpty] whileFalse: [ |e pulse input output|
		e := queue removeFirst. pulse := e at: 1. input := e at: 2. output := e at: 3.
		(output ~= 'output') & (output ~= 'rx') ifTrue: [
			(modules at: output) send: pulse from: input circuit: self
		].
	].! !

!Day20Circuit methodsFor: 'as yet unclassified' stamp: 'jaw 12/20/2023 16:40'!
pushButtonAndCount: times
	times timesRepeat: [self pushButton].
	^ lowPulses * highPulses! !

!Day20Circuit methodsFor: 'as yet unclassified' stamp: 'jaw 12/20/2023 16:40'!
pushButtonAndMonitorRx
	|rxInput pushes|
	rxInput := (modules values) detect: [:module | (module outputs) includes: 'rx'] ifNone: [nil].
	rxInput startMonitoring.
	pushes := 0.
	[(rxInput periods) allSatisfy: [:p | p > 0]] whileFalse: [
		pushes := pushes + 1.
		rxInput setPushes: pushes.
		self pushButton.
	].
	^ ((rxInput periods) values) inject: 1 into: [:a :c | a lcm: c].! !

!Day20Circuit methodsFor: 'as yet unclassified' stamp: 'jaw 12/20/2023 16:40'!
send: pulse from: input to: output
	queue add: {pulse . input . output}.
	pulse ifFalse: [lowPulses := lowPulses + 1] ifTrue: [highPulses := highPulses + 1].! !

!Day20Circuit methodsFor: 'as yet unclassified' stamp: 'jaw 12/20/2023 16:40'!
updateInputs
	modules keysAndValuesDo: [:name :module |
		(module outputs) do: [:output |
			(modules includesKey: output) ifTrue: [
				(modules at: output ifAbsent: []) addInput: name.
			].
		].
	].! !
