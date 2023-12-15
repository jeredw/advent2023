file := FileStream fileNamed: 'day14-input.txt'.
lines := OrderedCollection new.
[file atEnd] whileFalse: [lines add: (file nextLine)].
answer1 := ((Day14Platform new init: lines) tiltNorth) countLoad.
answer2 := (Day14Platform new init: lines) cycleTimes: 1000000000.

Transcript clear.
Transcript show: answer1; cr.
Transcript show: answer2; cr.