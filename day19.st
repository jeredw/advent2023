file := FileStream fileNamed: 'day19-input.txt'.
emptyLine := false.
workflows := Dictionary new.
[emptyLine] whileFalse: [
	line := file nextLine.
	((line size) = 0) ifTrue: [
		emptyLine := true
	] ifFalse: [ |w|
		w := Day19Workflow new init: line.
		workflows at: (w name) put: w.
	].
].
program := Day19Program new init: workflows.
parts := OrderedCollection new.
[file atEnd] whileFalse: [
	line := file nextLine.
	parts add: (Day19Part new init: line).
].

answer1 := (parts select: [:p | program accept: p])
	inject: 0 into: [:a :p | a + (p sumVars)].
answer2 := program count: (1 to: 4000).

Transcript clear.
Transcript show: answer1; cr.
Transcript show: answer2; cr.