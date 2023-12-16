'From Squeak6.0 of 5 July 2022 [latest update: #22104] on 16 December 2023 at 2:16:28 pm'!
Object subclass: #Day16Contraption
	instanceVariableNames: 'grid up down left right'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!Day16Contraption methodsFor: 'as yet unclassified' stamp: 'jaw 12/16/2023 14:12'!
init: lines
	grid := Matrix
		rows: (lines size)
		columns: ((lines at: 1) size)
		tabulate: [:j :i | (lines at: j) at: i].
	up := (0@(-1)).
	down := (0@1).
	left := ((-1)@0).
	right := (1@0).! !

!Day16Contraption methodsFor: 'as yet unclassified' stamp: 'jaw 12/16/2023 14:12'!
traceFrom: start heading: startDir
	|open visited enqueue|
	open := OrderedCollection new.
	visited := Set new.
	enqueue := [:p |
		(((p first) y) between: 1 and: (grid rowCount)) &
		(((p first) x) between: 1 and: (grid columnCount)) ifTrue: [
			(visited includes: p) | (open includes: p) ifFalse: [
				open add: p.
			].
		].
	].
	enqueue value: {start . startDir}.
	[(open size) > 0] whileTrue: [ |ray p dir ch|
		ray := open removeFirst.
		p := ray at: 1.
		dir := ray at: 2.
		visited add: ray.
		ch := grid at: (p y) at: (p x).
		(ch = $-) ifTrue: [
			((dir = up) | (dir = down)) ifTrue: [
				enqueue value: {p + left . left}.
				enqueue value: {p + right . right}.
			] ifFalse: [
				enqueue value: {p + dir . dir}.
			].
		].
		(ch = $|) ifTrue: [
			((dir = left) | (dir = right)) ifTrue: [
				enqueue value: {p + up . up}.
				enqueue value: {p + down . down}.
			] ifFalse: [
				enqueue value: {p + dir . dir}.
			].
		].
		(ch = $/) ifTrue: [
			(dir = up) ifTrue: [enqueue value: {p + right . right}].
			(dir = right) ifTrue: [enqueue value: {p + up . up}].
			(dir = down) ifTrue: [enqueue value: {p + left . left}].
			(dir = left) ifTrue: [enqueue value: {p + down . down}].
		].
		(ch = $\) ifTrue: [
			(dir = up) ifTrue: [enqueue value: {p + left . left}].
			(dir = left) ifTrue: [enqueue value: {p + up . up}].
			(dir = down) ifTrue: [enqueue value: {p + right . right}].
			(dir = right) ifTrue: [enqueue value: {p + down . down}].
		].
		(ch = $.) ifTrue: [
			enqueue value: {p + dir . dir}.
		].
	].
	^ ((visited collect: [:p | (p first)]) asSet) size.! !

!Day16Contraption methodsFor: 'as yet unclassified' stamp: 'jaw 12/16/2023 14:15'!
traceMax
	|best|
	best := 0.
	1 to: (grid columnCount) do: [:i |
		best := best max: (self traceFrom: i@1 heading: down).
		best := best max: (self traceFrom: i@(grid rowCount) heading: up).
	].
	1 to: (grid rowCount) do: [:j |
		best := best max: (self traceFrom: 1@j heading: right).
		best := best max: (self traceFrom: (grid columnCount)@j heading: left).
	].
	^ best! !
