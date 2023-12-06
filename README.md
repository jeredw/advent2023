# Advent of code 2023

Let's try Smalltalk this year!  I think I read a book about Smalltalk-80 over
20 years ago, but I remember almost nothing about it, so this should be fun.

I'm starting off with [Squeak](https://squeak.org/), but might move to
[Pharo](https://pharo.org/web/) later if it seems nicer?

I am really not sure how to publish my code.  It seems like my program lives
inside a 60MB VM image of some sort.  Distributing this file feels odd, so I'm
just making a "project" for each day with a workspace where I'm solving
problems, and including a .text transcript that I am then turning into a source
file for now.

## Day 1

The core language is a really nice little functional language with a nice
collections library.  Googling for stuff turns up wiki pages from the early
2000s with serious [Prof. Dr.
Style](http://contemporary-home-computing.org/prof-dr-style/) aesthetics, and
inexplicably a bunch of PDFs from French universities.  It is pretty clear that
nobody uses this language.

## Day 2

Today nothing was printing out in the output window when I did `Transcript
show: 'foo'.`  It turns out that I foolishly opened it by going to Tools >
Transcript instead of middle clicking on the skeuomorphic metallic window
background and selecting "Transcript" from the "World" menu.  And thus, I was
really looking at "Transcript #2".

I have no idea how you print stuff to Transcript #2 vs #1 or what the "World"
menu is for, but that is 10 minutes of my life I'm never getting back.  I am
beginning to form a negative opinion of the Squeak GUI.

It was interesting trying to figure out if there were regular expressions in
Smalltalk.  Yes there are, Virginia!  It seems like the way to find out stuff
about libraries is just to inspect all the running code using a sort of object
browser thing.  You can find classes and methods and stuff by introspection.
But none of the standard library code has any docs, so you can guess at method
names and find them, but you can't really see how to use stuff.

At this point I think I get the language, but I still have no idea how to make
new classes or methods -- there does not seem to be dedicated grammar for this,
I probably have to use the World menu.  Fortunately you can assign blocks
(closures) to variables and then pass them the "value" message, so I kind of
have procedures.  I really need to go find a tutorial or something.

## Day 3

Today I accidentally deleted the project for day 2 somehow.  I closed it to
make a project for day 3, and I must've dismissed a dialog too fast -- welp.
This is clearly a GUI built by unforgiving computer scientists.

My hunch on day 2 was right.  I found a YouTube video recorded 12 years ago by
some guy in Indiana.  As his land line telephone rang in the background, he
explained how you can make new classes using the "Browser" window, and add
methods there too.  Possibly this is all explained in some documentation that I
have just overlooked because I learn about things inside out, but frankly
watching someone use the Squeak GUI is worth 10,000 words.

It is not magic, you're just doing `Object subclass`, but the Browser is where
Squeak wants you to do it.  I thought about making some classes today to get
named tuples, but I decided it was too much clicking for a tiny program.  Maybe
tomorrow.

Somehow, besides the now 71MB VM image, my repository has aquired more stuff.
There is a directory called `Squeaklets` now and a .gif file with a fuzzy
screenshot.  This is all very mysterious.

## Day 4

I deleted day 3 again!  I was even super careful to click "Save", but the
project is just gone now.  It was [a really great
project](https://www.youtube.com/watch?v=c72d4-LpilM).

I remembered enough libraries that I didn't have to hunt around through docs a
lot.  This was a pretty easy counting problem which was a nice relaxing problem
for an early Monday.  I still have not made a new class.

## Day 5

Ok, I think the trick is not to "close" the day N-1 project, but just to go
"back" to the parent project.  I finally managed to keep my day 4 project.

Today's problem was finicky enough that I had to debug my program.  When
something went wrong, a stack trace window popped up and let me see the error a
couple levels down from my user code.  But I couldn't tell how to see the
values of my variables.  And the transcript kept printing out messages about
stuff not being defined, as if it kept going for a few seconds after the error.
I will have to figure this out in coming days.

Most of my mysterious bugs were to do with parentheses.  Smalltalk seems to
have really limited arithmetic precedence, and I found I was better off just
extracting subexpressions when it got too tricky.

I found myself wishing `Interval` had a few more convenience methods for
interval arithmetic, and I think if I were a real Smalltalk person, I would
probably have just added them and made my program nicer.
