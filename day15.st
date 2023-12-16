hash := [:s | s inject: 0 into: [:a :c | 17 * (a + (c asInteger)) \\ 256]].

file := FileStream fileNamed: 'day15-input.txt'.
strings := (file nextLine) findTokens: ','.

"part 1"
sum := strings inject: 0 into: [:a :c | a + (hash value: c)].

"part 2"
boxes := (OrderedCollection ofSize: 256) collect: [:t | OrderedCollection new].
findBox := [:label | boxes at: (1 + (hash value: label))].
strings do: [:s |
	(s includes: $-) ifTrue: [ |label|
		label := s copyFrom: 1 to: ((s size) - 1).
		(findBox value: label) removeAllSuchThat: [:kv | (kv first) = label].
	] ifFalse: [ |kv box i|
		kv := s findTokens: '='.
		box := findBox value: (kv first).
		i := box findFirst: [:each | (each first) = (kv first)].
		i > 0 ifTrue: [box at: i put: kv] ifFalse: [box add: kv].
	].
].
census := 0.
boxes withIndexDo: [:box :i |
	box withIndexDo: [:kv :j | |power|
		power := (kv at: 2) asInteger.
		census := census + (i * j * power).
	].
].

Transcript clear.
Transcript show: sum; cr.
Transcript show: census; cr.