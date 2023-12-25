'From Squeak6.0 of 20 December 2023 [latest update: #22147] on 24 December 2023 at 6:51:16 pm'!
Object subclass: #Day24Hailstone
	instanceVariableNames: 'position velocity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!Day24Hailstone methodsFor: 'as yet unclassified' stamp: 'jaw 12/24/2023 18:30'!
after: t
	^ Day24Point3
		x: (position x + (t * velocity x))
		y: (position y + (t * velocity y))
		z: (position z + (t * velocity z))! !

!Day24Hailstone methodsFor: 'as yet unclassified' stamp: 'jaw 12/24/2023 18:30'!
coplanar: other
	|uxv pmq|
	uxv := velocity crossProduct: (other velocity).
	pmq := position - (other position).
	^ (pmq dotProduct: uxv) = 0! !

!Day24Hailstone methodsFor: 'as yet unclassified' stamp: 'jaw 12/24/2023 18:30'!
intersectxy: other min: min max: max
	|x1 y1 x2 y2 x3 y3 x4 y4 d d1 d2 p s1 s2 |
	x1 := position x. y1 := position y.
	x2 := (position + velocity) x. y2 := (position + velocity) y.
	x3 := other position x. y3 := other position y.
	x4 := (other position + other velocity) x. y4 := (other position + other velocity) y.
	d := ((x1 - x2) * (y3 - y4)) - ((y1 - y2) * (x3 - x4)).
	d = 0 ifTrue: [^ #parallel].
	d1 := (x1 * y2) - (y1 * x2).
	d2 := (x3 * y4) - (y3 * x4).
	p := (((d1 * (x3 - x4)) - ((x1 - x2) * d2)) / d) @ (((d1 * (y3 - y4)) - ((y1 - y2) * d2)) / d).
	s1 := (((p x) - x1) @ ((p y) - y1)) dotProduct: (velocity x @ velocity y).
	s2 := (((p x) - x3) @ ((p y) - y3)) dotProduct: (other velocity x @ other velocity y).
	true caseOf: {
		[(s1 < 0) & (s2 < 0)] -> [^ #bothpast].
		[s1 < 0] -> [^ #apast].
		[s2 < 0] -> [^ #bpast].
		[true] -> [
			((p x between: min and: max) &
			 (p y between: min and: max)) ifTrue: [^ #inside].
			^ #outside.
		]
	}.! !

!Day24Hailstone methodsFor: 'as yet unclassified' stamp: 'jaw 12/24/2023 18:30'!
parallel: other
	^ ((velocity x / other velocity x) = (velocity y / other velocity y)) &
	    ((velocity x / other velocity x) = (velocity z / other velocity z))! !

!Day24Hailstone methodsFor: 'as yet unclassified' stamp: 'jaw 12/24/2023 18:30'!
position
	^ position! !

!Day24Hailstone methodsFor: 'as yet unclassified' stamp: 'jaw 12/24/2023 18:30'!
position: t1 velocity: t2
	position := t1.
	velocity := t2.! !

!Day24Hailstone methodsFor: 'as yet unclassified' stamp: 'jaw 12/24/2023 18:30'!
printOn: aStream
	position printOn: aStream.
	aStream nextPutAll: ' @ '.
	velocity printOn: aStream.! !

!Day24Hailstone methodsFor: 'as yet unclassified' stamp: 'jaw 12/24/2023 18:30'!
velocity
	^ velocity! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Day24Hailstone class
	instanceVariableNames: ''!

!Day24Hailstone class methodsFor: 'as yet unclassified' stamp: 'jaw 12/24/2023 18:30'!
fromString: str
	|pv|
	pv := str splitBy: ' @ '.
	^ self new
		position: (Day24Point3 fromString: (pv at: 1))
		velocity: (Day24Point3 fromString: (pv at: 2)).! !
