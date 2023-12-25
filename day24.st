file := FileStream fileNamed: 'day24-input.txt'.
stones := OrderedCollection new.
[file atEnd] whileFalse: [
	line := file nextLine.
	stones add: (Day24Hailstone fromString: line).
].

Transcript clear.
count := 0.
min := 200000000000000.
max := 400000000000000.
1 to: stones size do: [:i |
	(i + 1) to: stones size do: [:j | |a b|
		a := stones at: i. b := stones at: j.
		(a intersectxy: b min: min max: max) = #inside ifTrue: [
			count := count + 1.
		].
	].
].
Transcript show: count; cr.

s1 := stones at: 1.
x := (s1 position) x.
y := (s1 position) y.
z := (s1 position) z.
dx := (s1 velocity) x.
dy := (s1 velocity) y.
dz := (s1 velocity) z.
2 to: 5 do: [:i | |os odx ody odz ox oy oz|
	os := stones at: i.
	ox := (os position) x.
	oy := (os position) y.
	oz := (os position) z.
	odx := (os velocity) x.
	ody := (os velocity) y.
	odz := (os velocity) z.
	Transcript show: {(ody - dy) . (dx - odx) . (y - oy) . (ox - x) . ((ox * ody) - (oy * odx) - (x * dy) + (y * dx))}; cr.
].
2 to: 5 do: [:i | |os odx ody odz ox oy oz|
	os := stones at: i.
	ox := (os position) x.
	oy := (os position) y.
	oz := (os position) z.
	odx := (os velocity) x.
	ody := (os velocity) y.
	odz := (os velocity) z.
	Transcript show: {(odz - dz) . (dx - odx) . (z - oz) . (ox - x) . ((ox * odz) - (oz * odx) - (x * dz) + (z * dx))}; cr.
].
