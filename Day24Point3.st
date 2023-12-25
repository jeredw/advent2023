'From Squeak6.0 of 20 December 2023 [latest update: #22147] on 24 December 2023 at 6:51:13 pm'!
Object subclass: #Day24Point3
	instanceVariableNames: 'x y z'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!Day24Point3 methodsFor: 'as yet unclassified' stamp: 'jaw 12/24/2023 18:30'!
+ other
	^ Day24Point3 x:(x + (other x)) y:(y + (other y)) z:(z + (other z))! !

!Day24Point3 methodsFor: 'as yet unclassified' stamp: 'jaw 12/24/2023 18:30'!
- other
	^ Day24Point3 x:(x - (other x)) y:(y - (other y)) z:(z - (other z))! !

!Day24Point3 methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 10:25'!
= other
	^ (x = (other x)) & (y = (other y)) & (z = (other z))! !

!Day24Point3 methodsFor: 'as yet unclassified' stamp: 'jaw 12/24/2023 18:30'!
crossProduct: p
	|s1 s2 s3|
	s1 := (y * (p z)) - (z * (p y)).
	s2 := (z * (p x)) - (x * (p z)).
	s3 := (x * (p y)) - (y * (p x)).
	^ Day24Point3 x: s1 y: s2 z: s3! !

!Day24Point3 methodsFor: 'as yet unclassified' stamp: 'jaw 12/24/2023 18:30'!
dotProduct: p
	^ (x * (p x)) + (y * (p y)) + (z * (p z))! !

!Day24Point3 methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 10:24'!
hash
	^ (x hash hashMultiply + y hash hashMultiply + z hash) hashMultiply! !

!Day24Point3 methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:11'!
printOn: aStream
	aStream nextPut: $(.
	x printOn: aStream.
	aStream nextPutAll: ', '.
	y printOn: aStream.
	aStream nextPutAll: ', '.
	z printOn: aStream.
	aStream nextPut: $).! !

!Day24Point3 methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:11'!
printString
	^ '(', x, ', ' , y, ', ', z, ')'! !

!Day24Point3 methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 10:28'!
setX: t1 setY: t2 setZ: t3
	x := t1.
	y := t2.
	z := t3.! !

!Day24Point3 methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 10:04'!
x
	^ x! !

!Day24Point3 methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 10:04'!
y
	^ y! !

!Day24Point3 methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 10:04'!
z
	^ z! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Day24Point3 class
	instanceVariableNames: ''!

!Day24Point3 class methodsFor: 'as yet unclassified' stamp: 'jaw 12/24/2023 18:30'!
fromString: str
	|cs|
	cs := (str findTokens: ',') collect: [:c | c asInteger].
	^ self new setX: (cs at: 1) setY: (cs at: 2) setZ: (cs at: 3).! !

!Day24Point3 class methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 10:30'!
x: t1 y: t2 z: t3
	^ self new setX: t1 setY: t2 setZ: t3! !
