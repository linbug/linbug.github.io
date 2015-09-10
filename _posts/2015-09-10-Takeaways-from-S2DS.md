---
layout: post
title:  Takeaways from S2DS 
category: data science
comments: true
---

After five weeks of data science in London, S2DS is over. I can track my life this summer through my Github contributions: 

<img src="https://raw.githubusercontent.com/linbug/linbug.github.io/master/_downloads/Github_contributions-01.jpg" title="Github year" style="margin: 0 auto;"/>

Conclusion: thesis writing = bad for coding. (Note: most of the past few weeks’ contributions won’t show up on my public profile, since we’ve been working on a private repo).

Our last week was tiring. To get ready for our final presentations, my team ended up working all day, eating take-out dinner in front of our screens, and finishing up with a late-night work party in the kitchen. Over the following few days we gave two presentations (one to our cohort and one to our sponsor company), and had two celebratory nights out (one in a nice pub in Harrow-on-the-Hill, and one in the bar in the Oxo tower). I slept all weekend.

<iframe src="//giphy.com/embed/ohqwEPmfK3Ouc" width="480" height="260" frameBorder="0" align = "centre" class="giphy-embed" allowFullScreen></iframe>

So, what were my main takeaways from the course?

**********************

### Size matters
I’ve never previously had to work with data that wouldn’t fit into memory. A lot of the issues we had in my team during the first couple of weeks was deciding how to deal with a large dataset (>100 GB if we’d exported to csv). I was somehow (naively) surprised by this. Our solution (export small, randomised chunks to csvs) was fine for exploratory analyses and building our model, but if we’d have wanted to work routinely with much larger datasets we might have started using cluster computing big data tools like Hadoop and Spark. We had lectures about these technologies, but I haven’t got my head around how they work yet, how they relate to each other and when it’s appropriate to use them. Similarly, it was clear that databases are used much more in industry than they are in academia; SQL has been promoted to the top of my ’skills I need to brush up on’ list.

### Collaborating using Github is messy if you don’t really know what’s going on
Although I’ve used git a lot for personal projects, I’ve had limited experience working in a team on this platform. As a lone worker, you rarely have to deal with things many of the more complicated git features, like remembering to pull from the remote to update your local copy with whatever your team mate did, or resolving merge conflicts. In my team, we had a lack of understanding about committing, pulling and pushing workflows, and ended up with some really messy commit histories as a result. After some useful conversations with a fellow S2DSer about best practices (he recommend we branch often, or get used to using pull requests) we tidied up our workflow somewhat. It’s possible to muddle along with git without really knowing what’s going on under the hood, but I’d really like to develop a thorough understanding of how it works. [This](http://maryrosecook.com/blog/post/git-from-the-inside-out) blog post I found might help with that. 

### Much more teamwork was required than in academia
My team worked side by side almost all of the time. I really enjoyed this element -  it meant that successes were shared and problems were brainstormed with others. However, it did require a higher degree of mindfulness about how we were communicating than I was expecting. At times this was exhausting, but on balance I preferred this to working completely on my own (as I was for most of the time during my PhD). I’m not clear about how representative this experience is of Data Science jobs in industry: I suppose it depends a lot on the organisation you work for.

### Networking is important
In my opinion, one of the most valuable takeaways from any course of this kind is the network of people that you walk away with at the end. I learned a lot just from chatting with other S2DSers about what resources to look at for skills-building, what a data science job interview is like, and what it’s like to live in [insert country here]. I’m sure that many people will continue to help each other out in the search for data science jobs, and beyond. It was also clear that networking paid off at evening events and data science meetups. Many people ended up making new contacts through these events, some of which were followed up with further in-person meetings. Some companies even use Meetup events to scout for new hires. 

### Communication is half the battle
It’s a cliché, but it’s true: it doesn’t matter how great your data analysis is if you can’t communicate it to others. We spent a lot of time explaining what we were doing to our sponsor company, our S2DS mentors and to other fellows on the programme. A lot of Data Science seems to be about communicating your findings to the people who are paying you. You need to think about how you pitch these conversations; it’s unlikely that someone from a corporate background is going to care about the ins and outs of your machine learning model, but they are going to care a lot about how much profit you are earning/saving for them. 

### Don’t be too picky with your first job
This advice was repeated several times by different data scientists that spoke to us, so it must bear mentioning here: it’s ok if you don’t get the perfect job first time. Better to try something, get the experience, and move on after a few months, than wait around forever- as long as you can justify to a new employer why you left your old position (maybe you didn’t enjoy that industry/wanted more mentorship from senior data scientists etc.).But you shouldn’t be moving around too much otherwise it doesn’t look good.

**********************

I’ll wrap up there. Thanks for reading!

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
