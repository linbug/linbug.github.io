---
layout: post
title: 'Pseudocode Programming: fake it before you make it' 
category: programming
comments: true
---

I'm interested in exploring ways to write better code.  Ways of organising your workflow or your thoughts that are more advanced than 'write down the first thing that comes into your head'. Techniques that will help to produce clean, reliable and fault-tolerant code, or at least help you to arrive at the same conclusion you would have anyway but more efficiently.

Something that I learned about when skimming through [Code Complete 2 by Steve McConnell](https://www.amazon.co.uk/Code-Complete-Practical-Handbook-Construction/dp/0735619670) is the Pseudocode Programming Process. He seems to have been the one who invented it as I can't find references to it outside of this context.

The idea is a simple one: before you start writing code, plan what you will do in pseudocode first. It's very similar to what you would do in a whiteboarding interview, except without the sweaty anxiety of having to perform in front of a group of strangers.

The theory is that any kind of design process starts off with a bunch of preparatory work. You start off with drafts, wireframes or maquettes and iterate on these, front-loading your exploratory work while making mistakes is cheap. You don't think about touching your final medium until you have most of the fundamentals worked out. This applies to building a bridge, making a painting, writing a book, or coding some software. That's the idea, anyway. 

<img src="https://raw.githubusercontent.com/linbug/linbug.github.io/master/_downloads/last_supper.jpg" title="One of Da Vinci's preparatory sketches for The Last Supper. You don't think you're better than him, do you?" style="height: auto;margin: 0 auto;"/>


McConnell goes into a lot more detail than that, which I've heavily summarised below.

## The Pseudocode Programming Process, in brief

### First: define your prerequisites
This is your pre-pseudocode preparatory work. You should consider:

- what is the problem that the routine will solve?
- is the job of the routine well-defined, and does it fit cleanly into the overall design?
- what are the inputs, outputs, preconditions and postconditions?
- what will you call your routine? Make sure it's clear and unambiguous
- how will you test your routine?
- can you re-use functionality from standard or third-party libraries?
- what could possibly go wrong, and how will you handle errors?

### Next: design the routine in pseudocode
Now you can make your wireframe. During this stage you must resist the temptation, however hard it is, to write any code. You will really want to, but _do not start writing any real code_. The idea here is to get a high-level framework in place. If you start writing code, you are going to start worrying prematurely about implementation details. Instead you should:

- write in pseudocode, starting off from the general control flow and then get gradually more specific
- use precise, language-agnostic English (or your preferred human language)
- try out a few ideas, and pick the best one
- back up and think how you'd explain it to someone else
- keep refining until it feels like a waste of time not to write real code

### Finally: write real code
The time has come to write real code! What a relief.

- fill in the code below each comment, and use the pseudocode as higher level comments if you like
- mentally check whether any further refactoring is needed
- mentally check for errors
- test out the code for real, and fix any errors
- repeat as needed, going back to pseudocode if need be

## Trying it out

I experimentally used PPP last quarter to see if it would help me to write better code. Here's some of my thoughts about it:

- I must confess that I never managed to do all of the steps of the (condensed) set above. I bet I'm not the only one. You have to be really conscientious to not skip any, and I wasn't that conscientious. There's a huge temptation to take shortcuts/ jump straight in before completing the steps. However, as far as I see it pretty much the whole point is to try and resist this temptation. The true value of the technique comes from pausing to look at what you are trying to achieve from a high level before diving in.

- I found PPP most useful for tasks that were too big/complicated to hold in my head all at once. In these cases, PPP was useful for breaking them down and making them less intimidating. I got myself out a few ruts this way, where I was staring at my screen and didn't know where to start. 

- It felt sometimes that I had to check my ego before starting. Sometimes I felt too 'proud' to do PPP, I felt like I didn't 'need' it. Times when I've felt like this I probably ended up taking longer doing it the standard way (writing code as it came to me, and then going back and revising) than I would have using PPP.

- PPP didn't feel worth it for small things (a few lines of code), although I suspect the level of complication where PPP starts to be useful is probably lower than it first appears.

## In summary

PPP feels like a useful addition to my tool box, but I'm on the fence as to whether it'll end up staying there long term. I'm going to try it out on more complicated projects and see where it takes me.

-------------------------------------

_For more analysis and opinion about PPP, there's loads of interesting comments at the end of [this article](https://blog.codinghorror.com/pseudocode-or-code/)._
