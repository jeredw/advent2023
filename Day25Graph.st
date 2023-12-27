'From Squeak6.0 of 20 December 2023 [latest update: #22147] on 26 December 2023 at 10:03:59 pm'!
Object subclass: #Day25Graph
	instanceVariableNames: 'map edges'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'as yet unclassified'!

!Day25Graph methodsFor: 'as yet unclassified' stamp: 'jaw 12/26/2023 22:00'!
addEdgeBetween: u and: v
	|uNeighbors vNeighbors|
	uNeighbors := map at: u ifAbsent: [Set new].
	uNeighbors add: v.
	map at: u put: uNeighbors.
	vNeighbors := map at: v ifAbsent: [Set new].
	vNeighbors add: u.
	map at: v put: vNeighbors.
	edges at: u->v put: ((edges at: u->v ifAbsent:[0]) + 1).
	edges at: v->u put: ((edges at: v->u ifAbsent:[0]) + 1).! !

!Day25Graph methodsFor: 'as yet unclassified' stamp: 'jaw 12/26/2023 22:00'!
contractVertex: v into: u
	"add all edges of v to u and remove v"
	(self neighborsOf: v) do: [:w |
		w ~= u ifTrue: [self addEdgeBetween: u and: w].
	].
	"remove v from the graph"
	map removeKey: v.
	map keysAndValuesDo: [:w :wws |
		map at: w put: (wws select: [:ww | ww ~= v]).
	].! !

!Day25Graph methodsFor: 'as yet unclassified' stamp: 'jaw 12/26/2023 22:00'!
countConnectedTo: v
	|open visited|
	open := OrderedCollection with: v.
	visited := Set new.
	[open isEmpty] whileFalse: [ |current|
		current := open removeFirst.
		visited add: current.
		(map at: current) do: [:n |
			(visited includes: n) ifFalse: [
				open add: n.
			].
		].
	].
	^ visited size! !

!Day25Graph methodsFor: 'as yet unclassified' stamp: 'jaw 12/26/2023 22:00'!
edgesAt: v do: block
	|neighbors|
	neighbors := map at: v ifAbsent: [Set new].
	neighbors do: [:u | block value: u value: (edges at: u->v)].! !

!Day25Graph methodsFor: 'as yet unclassified' stamp: 'jaw 12/26/2023 22:00'!
initialize
	map := Dictionary new.
	edges := Dictionary new.! !

!Day25Graph methodsFor: 'as yet unclassified' stamp: 'jaw 12/26/2023 22:00'!
makeACopy
	|g|
	g := Day25Graph new.
	map keysAndValuesDo: [:u :vs |
		vs do: [:v | g addEdgeBetween: u and: v]
	].
	^ g! !

!Day25Graph methodsFor: 'as yet unclassified' stamp: 'jaw 12/26/2023 22:00'!
minCut
	"returns the product of component sizes after min cut using the steor-wagner algorithm
	following the implementation from networkx
	https://networkx.org/documentation/stable/_modules/networkx/algorithms/connectivity/stoerwagner.html#stoer_wagner"
	|g n cutValue contractions bestPhase bestCut reachable|
	g := self makeACopy.
	n := g size.
	self assert: n > 2.
	self assert: self size = (self countConnectedTo: (self randomVertex)).
	cutValue := n.
	contractions := OrderedCollection new.
	bestPhase := 0.


	"repeatedly pick a pair of nodes to contract until only one node is left"	
	1 to: (n - 1) do: [:i | |u v a h|
		"pick an arbitrary node u and init a = {u}"
		u := g randomVertex.
		a := Set with: u.
		"repeatedly pick the node not in a with most edge weight into a, 
		and add it until there is just one node left"
		h := Day25VertexHeap new.
		g edgesAt: u do: [:t :w | h insert: t weight: w].
		1 to: (n - (i - 1) - 2) do: [:j |
			"note the last u from this loop is used below"
			u := (h removeFirst) vertex.
			a add: u.
			g edgesAt: u do: [:t :w |
				(a includes: t) ifFalse: [
					h insertOrUpdate: t weight: w.
				].
			].
		].
		"now a and v define a cut of the phase"
		v := h first.
		v weight < cutValue ifTrue: [
			cutValue := v weight.
			bestPhase := i.
		].
		v := v vertex.
		"contract v and the last node added to a, ie u.
		that is, add all edges of v to u and remove v"
		contractions add: {u . v}.
		g contractVertex: v into: u.
	].

	"recover the best partition"
	g := Day25Graph new.
	1 to: (bestPhase - 1) do: [:i | |uv|
		uv := contractions at: i.
		g addEdgeBetween: (uv at: 1) and: (uv at: 2).
	].
	bestCut := (contractions at: bestPhase) at: 2.
	reachable := g countConnectedTo: bestCut.
	^ reachable * (n - reachable).! !

!Day25Graph methodsFor: 'as yet unclassified' stamp: 'jaw 12/26/2023 22:00'!
neighborsOf: v
	^ map at: v ifAbsent: [Set new]! !

!Day25Graph methodsFor: 'as yet unclassified' stamp: 'jaw 12/26/2023 22:00'!
randomVertex
	^ map keys atRandom! !

!Day25Graph methodsFor: 'as yet unclassified' stamp: 'jaw 12/26/2023 22:00'!
size
	^ map keys size! !

!Day25Graph methodsFor: 'as yet unclassified' stamp: 'jaw 12/26/2023 22:00'!
weightBetween: u and: v
	^ edges at: u->v! !
