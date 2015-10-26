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
*How many people do we need at a party before there is a 50/50 chance that two of them share a birthday?*

Two people sharing a birthday is awkward, especially if you share a group of friends with that person. The Birthday Problem is an example of probability problem where the answer contradicts our intuitions. At first glance it seems like you would need loads of people before before there is a 50% chance that two will share the same birthday. 100 maybe? The actual answer is *23* (that is, assuming that all birthdays are equally likely, and excluding people born on [Feb 29](https://en.wikipedia.org/wiki/February_29), which only happens once every 4 years).

How can we explain this seemingly unintuitive result? 

First, let's think about how many people we'd need to be absolutely certain that two people have the same birthday. Using the [pigeonhole principle](https://en.wikipedia.org/wiki/Pigeonhole_principle), imagine that we have 365 pigeon boxes in an aviary, each of which is labelled with a date. So box one is labelled, 'Jan 1', box two is labelled 'Jan 2', and so on. Now, if we have a large pigeon collection, with over 366+ birds, we know that at least two pigeons are going to have to share a box. (people born on a specific day) at least two pigeons/people will have to inhabit the same hole. By the same token, if we have over 365 people at a party, by default two will share the same birthday.

<img src="https://raw.githubusercontent.com/linbug/linbug.github.io/master/_downloads/boxes.jpg" title="Holes for pigeons" style="height: 600px;margin: 0 auto;"/>

Using our mathematical notation, if \\k\\ represents our group of people, when \\k > 365\\ then the probability of having a dual birthday is 1 (it's absolutely guaranteed to happen).

At the opposite extreme, if we have only one pigeon, it's absolutely impossible that it's going to share a hole with another pigeon. There just aren't enough pigeons! :( So this time if \\k = 1\\ then the probability of a shared birthday is 0.

<img src="https://raw.githubusercontent.com/linbug/linbug.github.io/master/_downloads/lonely.jpg" title="Dinner for one?" style="height: 600px;margin: 0 auto;"/>

What if the number of people at our party is between 2 and 365? How do we calculate the probability that there will be a shared birthday? It's easier to first work out what is the probability that *noone* will share a birthday, and then simply take this value away from one to find the probability that at least two people will share a birthday (this is one of the [axioms of probability](https://onlinecourses.science.psu.edu/stat414/node/8))

So for \\k\\ people, the total number of possible combiations of birthdays that we could have is just \\365^k\\, because we have 365 possible days for each person, and each person's birthday is independent of every other's so we just use the multiplication rule to calculate the number of possible permutations. 
probability that noone will share a birthday will be 

If you're taking this course, I can recommend William Chen's [cheat sheet](https://datastories.quora.com/The-Only-Probability-Cheatsheet-Youll-Ever-Need).