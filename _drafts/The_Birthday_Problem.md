---
layout: post
title: The Birthday Problem
category: probability
comments: true
---

I've been working through Harvard's [Statistics 101:Introduction to Probability course](http://isites.harvard.edu/icb/icb.do?keyword=k104821&pageid=icb.page676263) recently. I'm really enjoying it, and a large part of that is down to the lecturer in the videos, [Joe Blitzstein](http://www.people.fas.harvard.edu/~blitz/Site/Home.html). He has a really great manner; he strikes a really nice balance between including a lot of technical detail but also tries hard to make the concepts intuitive, rather than simply making you memorise a bunch of equations. He also has a really deadpan sense of humour, which I  appreciate when it crops up. You'll notice if you watch the videos that he's left-handed. Wikipedia says that "a slightly larger number of left-handers than right-handers are especially gifted in music and math", because their brains are wired differently from righties. I wonder if there are a disproportionate number of left-handed professors compared to the general population? Anyway, I digress...

I'm currently on lecture 5, and so far we've covered counting and combinatronics, and conditional probability. Recently a friend and I got talking about the [Birthday Problem](https://en.wikipedia.org/wiki/Birthday_problem), a very famous problem in probability theory. Although this was covered in the course, I couldn't remember the intuitive reasoning for the answer. I thought I'd try and explain it here.

##The Birthday Problem
The Birthday Problem asks: 
*How many people do we need in a room before there is a 50/50 chance that two of them share a birthday?*

Two people sharing a birthday is awkward, especially if you share a group of friends with that person. The Birthday Problem is an example of probability problem where the answer contradicts our intuitions. At first glance it seems like you would need loads of people before before there is a 50% chance that two will share the same birthday. 100 maybe? The actual answer is *23* (that is, assuming that all birthdays are equally likely, and excluding people born on [Feb 29](https://en.wikipedia.org/wiki/February_29), which only happens once every 4 years).

How can we explain this seemingly unintuitive result? 
Joe explains it in terms of 

First, let's think about how many people we'd need to be absolutely certain that two people have the same birthday. Using the [pigeonhole principle](https://en.wikipedia.org/wiki/Pigeonhole_principle), we know that if we have 365 'holes' (birthdays) that people can fit into, then with 366+ 'pigeons' (people born on a specific day)

<iframe src="//giphy.com/embed/TlK63Eu0ViBklB4v5RK" width="480" height="269" frameBorder="0" class="giphy-embed" allowFullScreen></iframe>

So if \\k\\ represents our group of people, if \\k > 365\\, then the probability of having a dual 

If you're taking this course, I can recommend William Chen's [cheat sheet](https://datastories.quora.com/The-Only-Probability-Cheatsheet-Youll-Ever-Need).