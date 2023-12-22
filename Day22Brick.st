'From Squeak6.0 of 5 July 2022 [latest update: #22104] on 22 December 2023 at 1:14:02 pm'!
Object subclass: #Day22Brick
	instanceVariableNames: 'p1 p2 id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!Day22Brick methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
do: block
	(p1 x) ~= (p2 x) ifTrue: [
		(p1 x) to: (p2 x) do: [:x |
			block value: (Day22Point3 x: x y: (p1 y) z: (p1 z))
		].
		^ self
	].
	(p1 y) ~= (p2 y) ifTrue: [
		(p1 y) to: (p2 y) do: [:y |
			block value: (Day22Point3 x: (p1 x) y: y z: (p1 z))
		].
		^ self
	].
	(p1 z) ~= (p2 z) ifTrue: [
		(p1 z) to: (p2 z) do: [:z |
			block value: (Day22Point3 x: (p1 x) y: (p1 y) z: z)
		].
		^ self
	].
	block value: p1.! !

!Day22Brick methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
fall
	p1 := (p1 down).
	p2 := (p2 down).! !

!Day22Brick methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
id
	^ id! !

!Day22Brick methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
printOn: aStream
	aStream nextPutAll: 'Brick-'.
	id printOn: aStream.! !

!Day22Brick methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
printString
	^ 'Brick-', id! !

!Day22Brick methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
setId: t1
	id := t1! !

!Day22Brick methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
setP1: t1 setP2: t2
	p1 := t1.
	p2 := t2.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Day22Brick class
	instanceVariableNames: ''!

!Day22Brick class methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
p1: t1 p2: t2
	^ self new setP1: t1 setP2: t2! !
