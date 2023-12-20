'From Squeak6.0 of 5 July 2022 [latest update: #22104] on 19 December 2023 at 10:06:01 pm'!
Object subclass: #Day19Workflow
	instanceVariableNames: 'name clauses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!Day19Workflow methodsFor: 'as yet unclassified' stamp: 'jaw 12/19/2023 22:00'!
applyTo: part
	clauses do: [:each | |p op q goto|
		p := each at: 1. op := each at: 2. q := each at: 3. goto := each at: 4.
		(op = #<) ifTrue: [
			((part vars) at: p) < q ifTrue: [^goto].
		].
		(op = #>) ifTrue: [
			((part vars) at: p) > q ifTrue: [^goto].
		].
		(op = #t) ifTrue: [^goto].
	].
! !

!Day19Workflow methodsFor: 'as yet unclassified' stamp: 'jaw 12/19/2023 22:00'!
clauses
	^clauses! !

!Day19Workflow methodsFor: 'as yet unclassified' stamp: 'jaw 12/19/2023 22:00'!
count: program ranges: inRanges
	|sum ranges|
	sum := 0.
	ranges := inRanges copy.
	clauses do: [:each | |p op q goto|
		p := each at: 1. op := each at: 2. q := each at: 3. goto := each at: 4.
		(op = #<) ifTrue: [ |r| "a < 10"
			r := ranges at: p.
			ranges at: p put: ((r min) to: ((r max) min: (q - 1))).
			sum := sum + (program count: goto ranges: ranges).
			ranges at: p put: (q to: (r max)).
		].
		(op = #>) ifTrue: [ |r| "a > 10"
			r := ranges at: p.
			ranges at: p put: (((r min) max: (q + 1)) to: (r max)).
			sum := sum + (program count: goto ranges: ranges).
			ranges at: p put: ((r min) to: q).
		].
		(op = #t) ifTrue: [
			sum := sum + (program count: goto ranges: ranges).
		].
	].
	^sum! !

!Day19Workflow methodsFor: 'as yet unclassified' stamp: 'jaw 12/19/2023 22:00'!
init: line
	|fields|
	fields := line findTokens: '{'.
	name := fields at: 1.
	fields := (fields at: 2) findTokens: ','.
	clauses := fields collect: [:expr | self parseClause: expr].! !

!Day19Workflow methodsFor: 'as yet unclassified' stamp: 'jaw 12/19/2023 22:00'!
name
	^name! !

!Day19Workflow methodsFor: 'as yet unclassified' stamp: 'jaw 12/19/2023 22:00'!
parseClause: expr
	|p goto|
	(expr includes: $}) ifTrue: [
		^{'' . #t . '' . (expr copyFrom: 1 to: ((expr size) - 1))}
	].
	p := expr findTokens: ':'.
	goto := p at: 2.
	((p at: 1) includes: $<) ifTrue: [
		p := (p at: 1) splitBy: '<'.
		^{(p at: 1) . #< . ((p at: 2) asInteger) . goto}
	].
	p := (p at: 1) splitBy: '>'.
	^{(p at: 1) . #> . ((p at: 2) asInteger) . goto}! !
