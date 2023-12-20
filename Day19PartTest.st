'From Squeak6.0 of 5 July 2022 [latest update: #22104] on 19 December 2023 at 10:05:47 pm'!
TestCase subclass: #Day19PartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassifiedTests'!

!Day19PartTest methodsFor: 'tests' stamp: 'jaw 12/19/2023 22:00'!
testExample
	|p|
	p := (Day19Part new) init: '{x=787,m=2655,a=1222,s=2876}'.
	self assert: (((p vars) at: 'x') = 787).
	self assert: (((p vars) at: 'm') = 2655).
	self assert: (((p vars) at: 'a') = 1222).
	self assert: (((p vars) at: 's') = 2876).
! !
