file := FileStream fileNamed: 'day13-input.txt'.
done := false.
lines := OrderedCollection new.
line := ''.
answer1 := 0.
answer2 := 0.
[done] whileFalse: [
	(file atEnd) ifTrue: [
		done := true.
		line := ''.
	] ifFalse: [
		line := file nextLine.
	].
	((line size) = 0) ifTrue: [
		bitmap := Day13Bitmap new init: lines.
		answer1 := answer1 + (bitmap scoreMirrors).
		answer2 := answer2 + (bitmap scoreMirrorsSmudge).
		lines := OrderedCollection new.
	] ifFalse: [
		lines add: line.
	].
].

Transcript clear.
Transcript show: answer1; cr.
Transcript show: answer2; cr.