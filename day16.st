file := FileStream fileNamed: 'day16-input.txt'.
contraption := Day16Contraption new init:
	(((file contentsOfEntireFile) splitBy: String lf)
		select: [:line | (line size) > 0]).

Transcript clear.
Transcript show: (contraption traceFrom: 1@1 heading: 1@0); cr.
Transcript show: (contraption traceMax); cr.