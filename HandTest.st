'From Squeak6.0 of 5 July 2022 [latest update: #22104] on 8 December 2023 at 12:24:04 am'!
TestCase subclass: #HandTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassifiedTests'!

!HandTest methodsFor: 'tests' stamp: 'jaw 12/8/2023 00:20'!
testJokerType
	self assert: (Hand fromCards: '32T3K') type = 2.
	self assert: (Hand fromCards: 'KK677') type = 3.
	self assert: (Hand fromCards: 'T55?5') type = 6.
	self assert: (Hand fromCards: 'KT??T') type = 6.
	self assert: (Hand fromCards: 'QQQ?A') type = 6.! !

!HandTest methodsFor: 'tests' stamp: 'jaw 12/7/2023 23:45'!
testLessEqual
	self assert: (Hand fromCards: 'AA8AA')
			<= (Hand fromCards: 'AAAAA').
	self deny: (Hand fromCards: 'AAAAA')
			<= (Hand fromCards: 'AA8AA').
	self assert: (Hand fromCards: '2AAAA')
			<= (Hand fromCards: '33332').
	self assert: (Hand fromCards: '77788')
			<= (Hand fromCards: '77888').
	self assert: (Hand fromCards: 'KTJJT') <= (Hand fromCards: 'KK677').
	self deny: (Hand fromCards: 'KK677') <= (Hand fromCards: 'KTJJT').! !

!HandTest methodsFor: 'tests' stamp: 'jaw 12/7/2023 22:45'!
testType
	self assert: (Hand fromCards: 'AAAAA') type = 7.
	self assert: (Hand fromCards: 'AA8AA') type = 6.
	self assert: (Hand fromCards: '23332') type = 5.
	self assert: (Hand fromCards: 'TTT98') type = 4.
	self assert: (Hand fromCards: '23432') type = 3.
	self assert: (Hand fromCards: 'A23A4') type = 2.
	self assert: (Hand fromCards: '23456') type = 1.! !
