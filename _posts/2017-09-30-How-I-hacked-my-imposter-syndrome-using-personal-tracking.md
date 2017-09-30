---
layout: post
title: How I hacked my imposter syndrome using personal tracking
category: [self-improvement, personal tracking, imposter syndrome]
comments: true
---

About nine months ago I started a job as a Data Scientist at [DueDil](https://www.duedil.com). As this is my first proper data science job, a lot of things have been new to me: a whole new stack, new workflows for project management (like managing job tickets), goal-setting practices such as quarterly [OKRs](https://en.wikipedia.org/wiki/OKR), not to mention the pace of development in a start-up. It wasn't surprising to me that these took some time to get familiar with. However, an unexpected block I had was my perception of my own abilities. After some time, I found myself getting stressed and frustrated when I hit a bug or something I couldn't understand.

I started to assume whenever I couldn't do something that I was at fault for not being able to see the answer right away. Other people around me seemed to be able to waltz in and fix the problem immediately. The stress I was experiencing made it harder to think clearly, which in turn made it even harder to troubleshoot the bugs. The feelings were sometimes close to panic. It was a really uncomfortable state to be in.

It was clear I hadn't prepared myself for the feelings of frustration that are familiar to [rookie and seasoned-developers alike](https://nedbatchelder.com//blog/201709/beginners_and_experts.html). And no, I haven't been living under a rock: I know what imposter syndrome is. I've listened to/read numerous talks, blogs and chat streams about it. Turns out, just knowing about a defect in your thought patterns isn't enough to fix it.

## Introducing: the surprise journal

One of my good friends suggested I try something she called a 'surprise journal'. The idea is that whenever you notice that you are surprised about something, you fill out an entry in the journal. You write down what surprised you, what you originally thought would happen, and what actually happened. Then later on, you can go back and review your entries and see what you've learned.

I decided that I'd adapt the idea for one of my OKRs this quarter. I thought that maybe by doing this, I could find some general patterns with things that I was getting stuck on, and that would help me to understand how I could improve myself. Actually, the journal ended up helping me in quite a different way to what I expected.

## Format and process

I tweaked the format a bit to suit my own needs. I set it out in a table in Google Sheets. The column headers that I settled on were:

- Date
- What was I surprised or confused by
- What I thought would happen
- What actually happened
- What did I learn
- Notes
- Category

I changed the criteria to include 'confusion', since this more accurately described my feelings than 'surprise' a lot of the time.

I decided that if I was stuck on a problem for more than about 15 minutes, then I'd include it in the journal. I didn't want to put everything in there, since it's typical to feel some level of confusion almost every other minute whilst coding, but most of these are tiny issues which are quickly resolved.

I'd try to fill out the first four columns first, whilst I was struggling with the bug. That way I didn't know what the solution was yet, and so I was filling it out in a state of uncertainty.

Once I had solved the problem (or gotten help from someone else), I filled in the 'what did I learn' column, and sometimes 'notes' if I needed more space for explanation.

Later on, after I had completed ten entries, I went back and filled out the 'category' column with a description of the problem domain. For example, some of my categories were *Spark*, *bash*, *S3* and *self-awareness*.

## An example entry

Here's an example of one of my entries. It won't make much sense out of context, but it gives a sense of how it looked.


| **Date** |August 7 2017 |
| **What I was surprised or confused by** | Why, when I run the data pipeline, are the metrics files not being appended together? |
| **What I thought would happen** | I expected a cumulative append of metrics files, rather than just one record for each date    |
| **What actually happened** | There was only the most recent record for each metric output. You can see in the Jenkins output that the three metrics files all run at the same time, so none has finished by the time the others look for a latest output file. Hence the more recent output cannot find any previous files to append |
| **What did I learn** | Checking the Jenkins output is a good way to figure out order of execution |
| **Notes** | - |
| **Category** | Spark, Jenkins |

## What did I learn?

I learned a lot of things while keeping the journal.

### Keeping the journal made me calmer whilst debugging
I realised after a while that keeping the journal allowed me to remove my ego from the situation. It became a reminder that the difficulties I were having were normal and expected. Even the name 'surprise' felt quite pleasant and positive. Soon I wasn't feeling stressed about the bugs any more. It was like they turned from personal failings into puzzles to be solved.

### I got used to the feeling of discomfort
Now I look back on it, starting the entry before I knew the answer may have been crucial to the journal's impact. It forced me to pause and face my feelings of discomfort. Usually, my first instinct when debugging is to try and fix the problem as quickly as possible, because feeling stuck is so damn unpleasant. This time, I had to pause for long enough to actually articulate the problem. This gave me practice at experiencing the feeling of uncertainty, which made this feeling more routine and less scary.

### Articulating the problem helped to solve it
Sometimes the journal became my rubber duck - articulating the problem helped me to get my thoughts in order and get to the answer quicker.

### Everyone else is not a wizard
Something important that happened more than once was that a problem I thought would be trivial for someone else to solve ended up stumping them too. This gave me confidence that actually I was no different to anyone else. I also got to see how other people reacted to and solved the problem. I saw that it was possible to take a while to solve something without that seeming like a black mark against the person's abilities.

### There wasn't something systematically wrong with my understanding
The thing I originally expected to happen (that I'd realise I was deficient in some area or other and that I would go away and read about it) didn't materialise. The categories of things I got stuck on were more a reflection of whatever I was working on at the time than some systematic flaw in my reasoning. Looking back at the entries, none of them seem embarrassing or shameful - anyone could have gotten confused by these things.

## Summary

In summary, this turned out to be a really useful tool for me to get some perspective and regain my confidence. I'm thinking about continuing it and maturing the format. I'd recommend it to anyone who wants to get a higher-level view on their problem-solving abilities.

--------------

*For those currently struggling with imposter syndrome, an additional resource I found really helpful when I was researching this topic was [this talk/blog post by Allison Kaptur](http://akaptur.com/blog/2015/10/10/effective-learning-strategies-for-programmers/) on effective learning strategies for programmers.*

<div id="disqus_thread"></div>
<script type="text/javascript">
    /* * * CONFIGURATION VARIABLES * * */
    var disqus_shortname = 'linbug';

    /* * * DON'T EDIT BELOW THIS LINE * * */
    (function() {
        var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
        dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
        (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
    })();
</script>
<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript" rel="nofollow">comments powered by Disqus.</a></noscript>
