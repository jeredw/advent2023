Transcript clear.
file := FileStream fileNamed: 'day5-input.txt'.
line := file nextLine.	"assume first line is seeds, that is, the initial keys"
keys := (((line splitBy: ': ') at: 2) splitBy: ' ') collect: [:t | t asInteger].
keyRanges := (keys pairsCollect:
	[:start :length | start to: start + (length - 1)]) asOrderedCollection.
nextKeys := OrderedCollection new.
nextKeyRanges := OrderedCollection new.
inMap := false.
readingFile := true.
[readingFile] whileTrue: [
	(file atEnd) ifFalse: [
		line := file nextLine.
	] ifTrue: [
		"inject a blank line to terminate the last map"
		line := ''.
		readingFile := false.
	].
	((line size) > 0) ifTrue: [
		inMap ifTrue: [
			"remap keys in the current range to their next keys"
			ranges := (line splitBy: ' ') collect: [:t | t asInteger].
			firstDest := ranges at: 1.
			firstSource := ranges at: 2.
			count := ranges at: 3.
			source := firstSource to: firstSource + (count - 1).
			"part 1: remap individual keys"
			1 to: (keys size) do: [:i |
				k := keys at: i.
				(source includes: k) ifTrue: [
					nextKeys add: firstDest + (k - firstSource).
					keys at: i put: -1.	"nil out remapped keys"
				].
			].
			"part 2: remap key ranges"
			"Transcript show: line; cr."
			"Transcript show: 'before '; show: keyRanges; cr."
			splitRanges := OrderedCollection new.
			1 to: (keyRanges size) do: [:i |
				r := keyRanges at: i.
				((r first) > (source last)) | ((r last) < (source first)) ifFalse: [
					"this key range overlaps this mapping"
					(r first) < (source first) ifTrue: [
						left := (r first) to: ((source first) - 1).
						splitRanges add: left.
						r := (source first) to: (r last).
					].
					(r last) > (source last) ifTrue: [
						right := ((source last) + 1) to: (r last).
						splitRanges add: right.
						r := (r first) to: (source last).
					].
					firstRemapped := firstDest + ((r first) - (source first)).
					lastRemapped := firstRemapped + ((r size) - 1).
					remapped := firstRemapped to: lastRemapped.
					nextKeyRanges add: remapped.
					keyRanges at: i put: (-1 to: -1).
				].
			].
			keyRanges addAll: splitRanges.
			"Transcript show: 'after '; show: keyRanges; show: nextKeyRanges; cr."
		] ifFalse: [
			"new map begins with a : line"
			inMap := (line at: (line size)) = $:.
		].
	] ifFalse: [
		"empty line ends the current map"
		inMap ifTrue: [
			"add remapped keys and copy unremapped keys"
			nextKeys addAll: (keys select: [:k | k ~= -1]).
			keys := nextKeys.
			nextKeys := OrderedCollection new.
			nextKeyRanges addAll: (keyRanges select: [:k | (k first) ~= -1]).
			keyRanges := nextKeyRanges.
			nextKeyRanges := OrderedCollection new.
		].
		inMap := false.
	].
].
big := 999999999999.
minKey := keys inject: big into: [:a :c | a min: c].
minKeyOfRanges := (keyRanges collect: [:r | r first]) inject: big into: [:a :c | a min: c].

Transcript show: minKey; cr.
Transcript show: minKeyOfRanges; cr.