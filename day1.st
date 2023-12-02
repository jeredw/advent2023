"the digits table matches each digit substring to its numeric value"
digits := #('one' 1 'two' 2 'three' 3 'four' 4 'five' 5 'six' 6 'seven' 7 'eight' 8 'nine' 9
			'1' 1 '2' 2 '3' 3 '4' 4 '5' 5 '6' 6 '7' 7 '8' 8 '9' 9).
file := FileStream fileNamed: 'day1-input.txt'.
sum := 0.
[file atEnd] whileFalse:
	[line := file nextLine.
	"find the first match position for each matching digit substring"
	firstOccurrenceOfDigit := (digits pairsCollect:
		[:str :value | {line findString: str. value}])
		select: [:t | (t at: 1) > 0].
	"get the value for the match with minimum position"
	firstDigit := (firstOccurrenceOfDigit inject: #(100 nil) into:
		[:x :y | ((x at: 1) < (y at: 1)) ifTrue: [x] ifFalse: [y]])
		at: 2.
	"find the last match position for each digit substring"
	lastOccurrenceOfDigit := digits pairsCollect:
		[:str :value | {line findLastOccurrenceOfString: str startingAt: 1. value}].
	"get the value for the match with maximum position"
	lastDigit := (lastOccurrenceOfDigit inject: #(0 nil) into:
		[:x :y | ((x at: 1) > (y at: 1)) ifTrue: [x] ifFalse: [y]])
		at: 2.
	number := 10 * firstDigit + lastDigit.
	sum := sum + number].
Transcript clear.
Transcript show: sum.