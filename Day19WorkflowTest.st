'From Squeak6.0 of 5 July 2022 [latest update: #22104] on 19 December 2023 at 10:05:50 pm'!
TestCase subclass: #Day19WorkflowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassifiedTests'!

!Day19WorkflowTest methodsFor: 'tests' stamp: 'jaw 12/19/2023 22:00'!
testApplyTo
	|w p1 p2 p3 p4|
	w := Day19Workflow new init: 'ex{x>10:one,m<20:two,a>30:R,A}'.
	p1 := Day19Part new init: '{x=20,m=10,a=40,s=0}'.
	p2 := Day19Part new init: '{x=10,m=10,a=40,s=0}'.
	p3 := Day19Part new init: '{x=10,m=20,a=40,s=0}'.
	p4 := Day19Part new init: '{x=10,m=20,a=30,s=0}'.
	self assert: ((w applyTo: p1) = 'one').
	self assert: ((w applyTo: p2) = 'two').
	self assert: ((w applyTo: p3) = 'R').
	self assert: ((w applyTo: p4) = 'A').! !

!Day19WorkflowTest methodsFor: 'tests' stamp: 'jaw 12/19/2023 22:00'!
testExample
	|w|
	w := (Day19Workflow new) init: 'px{a<2006:qkq,m>2090:A,rfg}'.
	self assert: ((w name) = 'px').
	self assert: ((w clauses) = (#(
		#('a' #< 2006 'qkq')
		#('m' #> 2090 'A')
		#('' #t '' 'rfg')
	) asOrderedCollection)).
	w := (Day19Workflow new) init: 'qqz{s>2770:qs,m<1801:hdj,R}'.
	self assert: ((w name) = 'qqz').
	self assert: ((w clauses) = (#(
		#('s' #> 2770 'qs')
		#('m' #< 1801 'hdj')
		#('' #t '' 'R')
	) asOrderedCollection)).! !
