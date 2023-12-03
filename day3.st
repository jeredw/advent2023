file := FileStream fileNamed: 'day3-input.txt'.
numbers := OrderedCollection new.	"y . startX to: endX . value"
symbols := OrderedCollection new.	"x@y . ch"
y := 1.
[file atEnd] whileFalse: [
	line := file nextLine.
	line := line , '.'.	"to detect the end of numbers at the right"
	number := 0.
	startOfNumber := 0.
	x := 1.
	line do: [:c |
		(c isDigit) ifTrue: [
			"append digit to the current number"
			(startOfNumber = 0) ifTrue: [ startOfNumber := x ].
			number := (10 * number) + (c digitValue).
		] ifFalse: [
			(startOfNumber ~= 0) ifTrue: [
				"finished scanning the current number"
				xs := startOfNumber to: (x - 1).
				numbers add: {y . xs . number}.
				number := 0.
				startOfNumber := 0.
			].
			(c = $.) ifFalse: [
				"note symbols"
				symbols add: {x@y . c}.
			].
		].
		x := x + 1
	].
	y := y + 1.
].
"sum numbers adjacent to symbols"
sum := 0.
numbers do: [:t |
	y := t at: 1.
	xs := t at: 2.
	number := t at: 3.
	adjacentXs := ((xs first) - 1) to: ((xs last) + 1).
	adjacentYs := (y - 1) to: (y + 1).
	symbols do: [:s |
		p := s at: 1.
		((adjacentXs includes: (p x)) & (adjacentYs includes: (p y))) ifTrue: [
			sum := sum + number.
		].
	].
].
"multiply and sum numbers next to gears"
sumOfGearRatios := 0.
symbols do: [:s |
	p := s at: 1.
	ch := s at: 2.
	adjacentNumbers := 0.
	product := 1.
	(ch = $*) ifTrue: [
		numbers do: [:t |
			y := t at: 1.
			xs := t at: 2.
			number := t at: 3.
			adjacentXs := ((xs first) - 1) to: ((xs last) + 1).
			adjacentYs := (y - 1) to: (y + 1).
			((adjacentXs includes: (p x)) & (adjacentYs includes: (p y))) ifTrue: [
				product := product * number.
				adjacentNumbers := adjacentNumbers + 1.
			].
		].
	].
	(adjacentNumbers = 2) ifTrue: [ sumOfGearRatios := sumOfGearRatios + product ].
].

Transcript clear.
Transcript show: sum; cr.
Transcript show: sumOfGearRatios; cr.
"Transcript show: numbers; cr."
"Transcript show: symbols; cr."