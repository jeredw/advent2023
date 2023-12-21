file := FileStream fileNamed: 'day20-input.txt'.
circuit := Day20Circuit new init.
[file atEnd] whileFalse: [
	line := file nextLine.
	circuit parseAndAdd: line.
].

Transcript clear.
Transcript show: (circuit pushButtonAndCount: 1000); cr.
Transcript show: (circuit pushButtonAndMonitorRx); cr.