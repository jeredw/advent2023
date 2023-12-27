'From Squeak6.0 of 20 December 2023 [latest update: #22147] on 26 December 2023 at 10:04:01 pm'!
Object subclass: #Day25VertexHeap
	instanceVariableNames: 'heap'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!Day25VertexHeap methodsFor: 'as yet unclassified' stamp: 'jaw 12/26/2023 22:00'!
first
	^ heap first! !

!Day25VertexHeap methodsFor: 'as yet unclassified' stamp: 'jaw 12/26/2023 22:00'!
initialize
	super initialize.
	heap := Heap new sortBlock: [:a :b | b <= a].! !

!Day25VertexHeap methodsFor: 'as yet unclassified' stamp: 'jaw 12/26/2023 22:00'!
insert: v weight: w
	heap add: (Day25VertexHeapItem vertex: v weight: w).! !

!Day25VertexHeap methodsFor: 'as yet unclassified' stamp: 'jaw 12/26/2023 22:00'!
insertOrUpdate: v weight: w
	|i|
	i := heap array findFirst: [:item | item ~= nil and: [item vertex = v]].
	i = 0 ifTrue: [ "newly inserted"
		self insert: v weight: w.
	] ifFalse: [ |item|
		item := heap removeAt: i.
		self insert: (item vertex) weight: (item weight) + w.
	].! !

!Day25VertexHeap methodsFor: 'as yet unclassified' stamp: 'jaw 12/26/2023 22:00'!
removeFirst
	^ heap removeFirst.! !

!Day25VertexHeap methodsFor: 'as yet unclassified' stamp: 'jaw 12/26/2023 22:00'!
size
	^ heap size! !
