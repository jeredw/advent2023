file := FileStream fileNamed: 'day6-input.txt'.
times := ((file nextLine) splitBy: ':') at: 2.
distances := ((file nextLine) splitBy: ':') at: 2.
raceTimes := (times findTokens: ' ') collect: [:t | t asInteger].
raceDistances := (distances findTokens: ' ') collect: [:t | t asInteger].
singleRaceTime := (times copyReplaceAll: ' ' with: '') asInteger.
singleRaceDistance := (distances copyReplaceAll: ' ' with: '') asInteger.

"part 1: count solutions"
marginOfError := 1.
raceTimes with: raceDistances do: [:t :recordDistance |
	waysToWin := 0.
	0 to: t do: [:holdTime |
		distance := holdTime * (t - holdTime).
		(distance > recordDistance) ifTrue: [
			waysToWin := waysToWin + 1.
		].
	].
	marginOfError := marginOfError * waysToWin.
].


"part 2: use the quadratic formula"
det := (singleRaceTime * singleRaceTime) - (4 * singleRaceDistance).
t1 := ((singleRaceTime - (det sqrt)) / 2) floor.
t2 := ((singleRaceTime + (det sqrt)) / 2) floor.

Transcript clear.
Transcript show: marginOfError; cr.
Transcript show: t2 - t1; cr.