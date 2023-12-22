'From Squeak6.0 of 5 July 2022 [latest update: #22104] on 22 December 2023 at 1:14:05 pm'!
Object subclass: #Day22Jenga
	instanceVariableNames: 'volume bricks supportedBy'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!Day22Jenga methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
addBrick: brick
	bricks add: brick.
	brick setId: (bricks size).
	self mark: brick.! !

!Day22Jenga methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
canFall: brick
	brick do: [:p | |below|
		((p z) = 1) ifTrue: [^ false].
		below := volume at: (p down) ifAbsent: [nil].
		(below ~= nil) & (below ~= brick) ifTrue: [^ false].
	].
	^ true! !

!Day22Jenga methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
collapse
	|someBrickFell|
	someBrickFell := true.
	[someBrickFell] whileTrue: [
		someBrickFell := false.
		bricks do: [:brick |
			(self canFall: brick) ifTrue: [
				self erase: brick.
				brick fall.
				self mark: brick.
				someBrickFell := true.
			].
		].
	].! !

!Day22Jenga methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
countSuperfluousBricks
	|extraCount chainCount|
	self findSupports.
	extraCount := 0.
	chainCount := 0.
	"stupid union-merge is good enough"
	bricks do: [:brick | |support|
		support := self countSupportedBy: brick.
		(support = 0) ifTrue: [extraCount := extraCount + 1].
		chainCount := chainCount + support.
	].
	^ {extraCount . chainCount}! !

!Day22Jenga methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
countSupportedBy: brickToDisintegrate
	|by stack grewStack|
	"this gives me a corrupt object!!"
	"by := supportedBy deepCopy."
	by := supportedBy copy.
	by keysDo: [:k | by at: k put: ((by at: k) copy)].
	stack := Set with: brickToDisintegrate.
	grewStack := true.
	[grewStack] whileTrue: [
		grewStack := false.
		by keysDo: [:brick |
			(stack includes: brick) ifFalse: [ |supporters|
				supporters := by at: brick ifAbsent: [self halt].
				supporters removeAllFoundIn: stack.
				(supporters isEmpty) ifTrue: [
					stack add: brick.
					grewStack := true.
				].
			].
		].
	].
	^ (stack size) - 1! !

!Day22Jenga methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
erase: brick
	brick do: [:p | volume removeKey: p ifAbsent: [self halt]]! !

!Day22Jenga methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
findSupports
	self collapse.
	bricks do: [:brick |
		brick do: [:p | |above|
			above := volume at: (p up) ifAbsent: [nil].
			(above ~= brick) & (above ~= nil) ifTrue: [ |supporters|
				supporters := supportedBy at: above ifAbsent: [Set new].
				supporters add: brick.
				supportedBy at: above put: supporters.
			].
		].
	].! !

!Day22Jenga methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
init
	bricks := OrderedCollection new.
	volume := Dictionary new.
	supportedBy := Dictionary new.! !

!Day22Jenga methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
mark: brick
	brick do: [:p |
		(volume includesKey: p) ifTrue: [self halt].
		volume at: p put: brick
	]! !

!Day22Jenga methodsFor: 'as yet unclassified' stamp: 'jaw 12/22/2023 13:14'!
volume
	^ volume! !
