'From Squeak6.0 of 20 December 2023 [latest update: #22147] on 26 December 2023 at 10:04:05 pm'!
Object subclass: #Day25VertexHeapItem
	instanceVariableNames: 'vertex weight'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!Day25VertexHeapItem methodsFor: 'as yet unclassified' stamp: 'jaw 12/26/2023 22:00'!
<= other
	^ self weight <= other weight! !

!Day25VertexHeapItem methodsFor: 'as yet unclassified' stamp: 'jaw 12/26/2023 22:00'!
setVertex: v setWeight: w
	vertex := v.
	weight := w.! !

!Day25VertexHeapItem methodsFor: 'as yet unclassified' stamp: 'jaw 12/26/2023 22:00'!
vertex
	^ vertex! !

!Day25VertexHeapItem methodsFor: 'as yet unclassified' stamp: 'jaw 12/26/2023 22:00'!
weight
	^ weight! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Day25VertexHeapItem class
	instanceVariableNames: ''!

!Day25VertexHeapItem class methodsFor: 'as yet unclassified' stamp: 'jaw 12/26/2023 22:00'!
vertex: v weight: w
	^ Day25VertexHeapItem new setVertex: v setWeight: w.! !
