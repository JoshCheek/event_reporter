# Event Reporter

One of my students was asking me about how to do testing on
[Event Reporter](http://tutorials.jumpstartlab.com/projects/event_reporter.html),
a project we gave them.

He was struggling with testing the high-level object that
did things like read what to do from stdin,
load a CSV, save the CSV, and print results to stdout.

Obviously this is a difficult thing to test... it talks to **everything**!
I generally knew what the answer was ("fix your design"),
but wanted to make sure that I understood the problem,
and that my advice was practical and would actually work.
So I decided to begin doing the project myself,
and observe what things I noticed, what considerations I was taking into account,
what decisions I made, and why.

This is that repo. In general, I try to document each piece in commit messages.
You'll see me fuck up, you'll see me go down a path and then realize I dislike it
and revert the commit to go back. You'll see that I didn't know where I
was necessarily going as I did these things, they evolved (and some still need
more evolution, they've begun to move in directions I like, but aren't
fully there yet).

Not sure if there is a good way to present a git history to someone,
but I'll hopefully look into it and find something to make it less
annoying to traverse through the history and see what things looked like
at each step and what changes were made. If anyone knows of a good tool, let me know!

Thanks to Steve Kinney for helping me work on it this morning.

## Core Problem: How do I test this code that talks to everything?

**When you have code that is hard to test, it is almost always a dependency problem.**
Remember those circles and arrows, where I said that arrows should point down,
and you want silos of functionality? Too many of those arrows are pointing in the wrong directions.
Maybe they are forming cycles instead of trees.

Process to solve this:

1. Identify that there is a problem: "I can't fucking figure out how to test this"
2. Identify the specific problem: Draw out the dependency diagram and figure out exactly where the hurt is.
3. Resolve the problem:
  - What is the responsibility (things that it does or things that it knows) or reference (thing that it talks to) that is causing it have this bad dependency?
  - Invert the arrow by moving the knowledge or the reference to the other side.

## Other things I noticed as I went through the problem

* **Test behaviour, not interfaces**
* **Make test as independent of presentation as possible.**
  In your brain you have an idea like "Mary's data is the first printed",
  identify how little you can assert about the printed string and still be confident
  in this value. Otherwise, you change something about the presentation (e.g. switch to spaces instead of tabs)
  and suddenly your tests are breaking, the error message is showing complex nearly-identical strings,
  but really, the *behavoiur* did not change, this test should not have broken.
  You don't need these hurdles in your path, try to mitigate them by keeping the assertion as independent
  from the presentation as possible.
* **Don't make decisions you don't need to.**
* **"wrong and obvious is better than wrong and obscure"**
  When you don't know what decision to make, try to choose the one that takes the least effort
  and leaves the most room for change in the future (even if it is uglier or clearly wrong)
  so leave wrongness at the highest level that it can reasonably be at
* **As requirements increase, introduce abstractions to handle them**
  Don't start with the abstraction.
  E.g. reqs around commands increased and become more complex,
  I wound up depending more on CommandIdentifier
  creating a object to handle this knowledge and decision making
* **FakeFS** is like StringIO for the file system ([homepage](https://github.com/defunkt/fakefs)).

## License

Code is released under WTFPL.

```
          DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

0. You just DO WHAT THE FUCK YOU WANT TO.
```
