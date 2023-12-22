'From Squeak6.0 of 5 July 2022 [latest update: #22104] on 22 December 2023 at 1:14:07 pm'!
Object subclass: #Day22Point3
	instanceVariableNames: 'x y z'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!Day22Point3 methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
= other
	^ (x = (other x)) & (y = (other y)) & (z = (other z))! !

!Day22Point3 methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
down
	^ Day22Point3 x: x y: y z: (z - 1).! !

!Day22Point3 methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
hash
	^ (x hash hashMultiply + y hash hashMultiply + z hash) hashMultiply! !

!Day22Point3 methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
printOn: aStream
	aStream nextPut: $(.
	x printOn: aStream.
	aStream nextPutAll: ', '.
	y printOn: aStream.
	aStream nextPutAll: ', '.
	z printOn: aStream.
	aStream nextPut: $).! !

!Day22Point3 methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
printString
	^ '(', x, ', ' , y, ', ', z, ')'! !

!Day22Point3 methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
setX: t1 setY: t2 setZ: t3
	x := t1.
	y := t2.
	z := t3.! !

!Day22Point3 methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
up
	^ Day22Point3 x: x y: y z: (z + 1).! !

!Day22Point3 methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
x
	^ x! !

!Day22Point3 methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
y
	^ y! !

!Day22Point3 methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
z
	^ z! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Day22Point3 class
	instanceVariableNames: ''!

!Day22Point3 class methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
fromString: str
	|cs|
	cs := (str findTokens: ',') collect: [:c | c asInteger].
	^ self new setX: (cs at: 1) setY: (cs at: 2) setZ: (cs at: 3).! !

!Day22Point3 class methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
x: t1 y: t2 z: t3
	^ self new setX: t1 setY: t2 setZ: t3! !
