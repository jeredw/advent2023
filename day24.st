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

solve := [:m |	"m is an augmented matrix for the system"
	1 to: (m rowCount) do: [:j | |s|
		"scale so diagonal element is 1"
		s := m at: j at: j.
		1 to: (m columnCount) do: [:i |
			m at: j at: i put: ((m at: j at: i) / s).
		].
		"subtract from all rows below to zero elements before diagonal"
		(j + 1) to: (m rowCount) do: [:k | |t|
			t := m at: k at: j.
			1 to: (m columnCount) do: [:i |
				m at: k at: i put: ((m at: k at: i) - (t * (m at: j at: i))).
			].
		].
	].
	"subtract rows below to zero elements after diagonal"
	((m rowCount) - 1) to: 1 by: -1 do: [:j |
		(m rowCount) to: (j + 1) by: -1 do: [:k | |s|
			s := m at: j at: k.
			1 to: (m columnCount) do: [:i |
				m at: j at: i put: ((m at: j at: i) - (s * (m at: k at: i))).
			].
		].		
	].
	"last column is the solution vector"
	m atColumn: (m columnCount).
].

m1 := Matrix rows: 4 columns: 5.
m2 := Matrix rows: 4 columns: 5.
s1 := stones at: 1.
x := (s1 position) x.
y := (s1 position) y.
z := (s1 position) z.
dx := (s1 velocity) x.
dy := (s1 velocity) y.
dz := (s1 velocity) z.
1 to: 4 do: [:j | |os odx ody odz ox oy oz|
	os := stones at: (j + 1).
	ox := (os position) x.
	oy := (os position) y.
	oz := (os position) z.
	odx := (os velocity) x.
	ody := (os velocity) y.
	odz := (os velocity) z.
	m1 at: j at: 1 put: (ody - dy).
	m1 at: j at: 2 put: (dx - odx).
	m1 at: j at: 3 put: (y - oy).
	m1 at: j at: 4 put: (ox - x).
	m1 at: j at: 5 put: ((ox * ody) - (oy * odx) - (x * dy) + (y * dx)).
	m2 at: j at: 1 put: (odz - dz).
	m2 at: j at: 2 put: (dx - odx).
	m2 at: j at: 3 put: (z - oz).
	m2 at: j at: 4 put: (ox - x).
	m2 at: j at: 5 put: ((ox * odz) - (oz * odx) - (x * dz) + (z * dx)).
].
xy := solve value: m1.
xz := solve value: m2.
Transcript show: (xy at: 1) + (xy at: 2) + (xz at: 2).
