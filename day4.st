file := FileStream fileNamed: 'day4-input.txt'.
"init an array counting cards with number N, initially zero"
countOfCardNumber := Array new: 200.
1 to: (countOfCardNumber size) do: [:t | countOfCardNumber at: t put: 0].
cardNumber := 1.	"assume card numbers increase monotonically from 1"
score := 0.
[file atEnd] whileFalse:[
	"parse stuff"
	line := file nextLine.
	line := line copyReplaceAll: '  ' with: ' '.	"double spaces confuse splitBy"
	numbers := (line splitBy: ': ') at: 2.	"chop off 'Card #: '"
	sets := numbers splitBy: ' | '.
	winningNumbers := (((sets at: 1) splitBy: ' ') collect: [:t | t asInteger]) asSet.
	chosenNumbers := (((sets at: 2) splitBy: ' ') collect: [:t | t asInteger]) asSet.
	winners := chosenNumbers intersection: winningNumbers.

	"part 1: 1 for the first and 2** after"
	cardScore := (2 ** ((winners size) - 1)) truncated.

	"part 2: wining more cards" 
	"there is one given card with current number plus however many more we won"
	countOfCurrentCard := (countOfCardNumber at: cardNumber) + 1.
	countOfCardNumber at: cardNumber put: countOfCurrentCard.
	(cardNumber + 1) to: (cardNumber + (winners size)) do: [:t |
		count := countOfCardNumber at: t.
		"each copy of the current card wins one more of k next cards"
		countOfCardNumber at: t put: count + countOfCurrentCard.
	].
	score := score + cardScore.
	cardNumber := cardNumber + 1.
].
totalCards := countOfCardNumber inject: 0 into: [:a :c | a + c].

Transcript clear.
Transcript show:score; cr.
Transcript show:totalCards; cr.