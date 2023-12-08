file := FileStream fileNamed: 'day7-input.txt'.
hands := OrderedCollection new.
handsWithJokers := OrderedCollection new.
[file atEnd] whileFalse: [
	line := file nextLine.
	fields := line splitBy: ' '.
	cards := fields at: 1.
	cardsWithJokers := cards copyReplaceAll: 'J' with: '?'.
	bid := (fields at: 2) asInteger.
	hands add: (Hand fromCards: cards withBid: bid).
	handsWithJokers add: (Hand fromCards: cardsWithJokers withBid: bid).
].
winnings := [:hands |
	hands sort.
	total := 0.
	1 to: (hands size) do: [:i |
		total := total + (i * (hands at: i) bid).
	].
	total
].

Transcript clear.
Transcript show: (winnings value: hands); cr.
Transcript show: (winnings value: handsWithJokers); cr.