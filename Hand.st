'From Squeak6.0 of 5 July 2022 [latest update: #22104] on 8 December 2023 at 12:22:45 am'!
Object subclass: #Hand
	instanceVariableNames: 'cards bid'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!Hand methodsFor: 'as yet unclassified' stamp: 'jaw 12/7/2023 23:53'!
<= t1 
	| t2 |
	t2 := '?23456789TJQKA'.
	self type < t1 type
		ifTrue: [^ true].
	self type = t1 type
		ifTrue: [self cards
				with: t1 cards
				do: [:t3 :t4 | 
					(t2 indexOf: t3) < (t2 indexOf: t4) ifTrue: [^true].
					(t2 indexOf: t3) > (t2 indexOf: t4) ifTrue: [^false]].
				^true].
	^ false! !

!Hand methodsFor: 'as yet unclassified' stamp: 'jaw 12/7/2023 23:31'!
bid
	^ bid! !

!Hand methodsFor: 'as yet unclassified' stamp: 'jaw 12/7/2023 22:51'!
cards
	^ cards! !

!Hand methodsFor: 'as yet unclassified' stamp: 'jaw 12/7/2023 23:32'!
init: t1
	cards := t1 asOrderedCollection.
	bid := 0! !

!Hand methodsFor: 'as yet unclassified' stamp: 'jaw 12/7/2023 23:32'!
init: t1 withBid: t2
	cards := t1 asOrderedCollection.
	bid := t2.! !

!Hand methodsFor: 'as yet unclassified' stamp: 'jaw 12/8/2023 00:20'!
type
	| t1 t2 t3 jokers nojokers jokerssize |
	t1 := cards sorted
				piecesCutWhere: [:t4 :t5 | t4 ~= t5].
	jokers := t1 detect: [:a | a includes: $?] ifNone: [#()].
	jokerssize := jokers size.
	nojokers := t1 reject: [:a | a includes: $?].
	t2 := nojokers size.
	t3 := nojokers
				inject: 0
				into: [:t4 :t5 | |groupsize|
					groupsize := (t5 size) + jokerssize.
					t4 > groupsize
						ifTrue: [t4]
						ifFalse: [groupsize]].
	(t2 = 1) | (t2 = 0)
		ifTrue: [^ 7].
	t2 = 2
		ifTrue: [t3 = 4
				ifTrue: [^ 6].
			^ 5].
	t2 = 3
		ifTrue: [t3 = 3
				ifTrue: [^ 4].
			^ 3].
	t2 = 4
		ifTrue: [^ 2].
	^ 1! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Hand class
	instanceVariableNames: ''!

!Hand class methodsFor: 'as yet unclassified' stamp: 'jaw 12/7/2023 22:41'!
fromCards: t1
	^ self new init: t1.! !

!Hand class methodsFor: 'as yet unclassified' stamp: 'jaw 12/7/2023 23:34'!
fromCards: t1 withBid: t2 
	^ self new init: t1 withBid: t2! !
