---
layout: post
title: Week 2 at RC - linking data to sound
categories: [coding, d3]
tags: [d3, RC]
comments: true
---

<style>

.axis path,
.axis line {
    fill: none;
    stroke: black;
    shape-rendering: crispEdges;
}

.axis text {
    font-family: sans-serif;
    font-size: 11px;
    fill: black;
}

.ylabel text {

	font-family: sans-serif;
    font-size: 8px;
    fill: black;
}

</style>


<div id="example3"></div>

Week 2 at RC has been spent making some creepy synthy wind chime-sounding things in d3. Roll your mouse over the bars and some discordant sounds will play! I used a library called riffwave.js to generate a sound that scales according to the length of the bars. For some reason the site where I got riffwave from seems to have [disappeared]( http://codebase.es/riffwave/)). There also wasn't a whole lot information about how to use it in the first place. However, I found this useful SO [answer](http://stackoverflow.com/questions/15326396/get-precise-notes-with-riffwave-js) describing how to use riffwave.js to output sounds of a specified frequency. I used d3's `.scale` method to create a linear scale that maps input values (using `.domain`) to a sound between 27 and 900 hz (the output `.range`):

{% highlight javascript linenos %}
var pianoScale = d3.scale.linear()
		.domain([0, d3.max(dataArray)])
		.range([27, 900]);

{% endhighlight %}

Then in the `myMouseoverFunction`, feeding in the following plays the audio:

{% highlight javascript linenos %}
var audio = simHertz(pianoScale(data));
audio.play();
{% endhighlight %}

I used sounds between 27 and 900 hz because they sounded the nicest. I originally had 27 to 4186 hz, mimicking an [88 key piano scale](https://en.wikipedia.org/wiki/Piano_key_frequencies), but the higher notes sounded horrible and screechy.

Changing the input data produces some interesting shapes and sounds. Here is a log curve:

<div id="example4"></div>

and my favourite, a modified sine wave:

<div id="example2"></div>

Endless hours of fun! I tried encoding a tune with this but I think the output sound frequencies are lies, as it sounded really off. Props to [Javier](https://github.com/jvalen) who helped a lot with getting the mouseover stuff working correctly. Code for this project is available [here](https://github.com/linbug/d3/blob/master/pianoviz.html), or, if you want the exact code I used on this site, [here]().

###Other stuff I did this week:

- I'm slowly working through Gelman and Hill's [Data Analysis Using Regression and Multilevel/Hierarchical Models](http://www.amazon.co.uk/Analysis-Regression-Multilevel-Hierarchical-Analytical/dp/052168689X/ref=sr_1_1?ie=UTF8&qid=1448212470&sr=8-1&keywords=gelman+hill), and learning how to implement linear models in R. 

- After [Mary's functional programming](http://maryrosecook.com/blog/post/a-practical-introduction-to-functional-programming) talk, I paired with [Lauren](https://github.com/laurenzlong) on re-coding some of the [underscore.js](http://underscorejs.org/) library in Python. I thought I understood what functional programming was about, but I found this exercise really challenging and unintuitive. I guess I need more practice.

- Got some useful links and advice about data science projects at RC from [Chris](https://github.com/chrisjryan). Next week, work with real data. For real, this time.


<script src = "http://d3js.org/d3.v3.min.js"></script>
<script src = "{{ site.base-url }}/riffwave.js"></script>
<script src = "{{ site.base-url }}/pianoviz.js"></script>

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