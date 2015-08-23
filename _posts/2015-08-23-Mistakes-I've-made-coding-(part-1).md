---
layout: post
title: Mistakes I've made coding (part 1)
category: coding
comments: true
---

*A quick S2DS update as preamble…*

Week three of S2DS has been and gone, and there’s been little time for blog writing - we’ve been kept busy! I’m having a lot of fun though, and my team have been making good progress. For the first couple of weeks we were attending a lot of lectures about coding, databases, business etc., but now we’re almost exclusively working on our team projects. There have also been quite a few evening events, some in the city, and some on campus. I’m planning on writing a post that gets into the specific details of my team’s project, but for now, know that there’s been a bit of this:

<img src= "https://raw.githubusercontent.com/linbug/linbug.github.io/master/_downloads/cafe.jpg" title="Cafe style" style="height: 400px;margin: 0 auto;"/>

a bit of this:

<img src="https://raw.githubusercontent.com/linbug/linbug.github.io/master/_downloads/skygarden.jpg" title="View from the sky garden" style="height: 600px;margin: 0 auto;"/>

and quite a bit of this:

<img src="https://raw.githubusercontent.com/linbug/linbug.github.io/master/_downloads/beers.jpg" title="beers in the park" style="height: 600px;margin: 0 auto;"/>

---------------------------------------------------------

##Mistakes I've made coding (part 1)

Now for the meat of this post.

Noticing when you did something wrong, or at least sub optimally, is an important part of the learning process. I especially like it when [organisations](http://www.givewell.org/about/shortcomings) [do it](https://80000hours.org/about/credibility/evaluations/mistakes/). While I’m building my skills, I thought I’d keep track of coding mistakes I’ve made along the way. Whereas many of these seem obvious in hindsight, they each swallowed up tens of minutes or even hours of my time as I tried to figure out why I wasn’t getting the result I expected. I know that these aren’t exactly difficult ‘confessions’ to make, but some are at least mildly embarrassing, and will hopefully become more so as I continue my progression towards coding greatness :). 

* Don’t ignore the structure of an array. `np.array([[0], [1]])` is NOT the same as `np.array([0, 1])`. For some reason I tend to have array blindness when I’m in the middle of a problem.

* Don't make an ipython notebook that prints out the output of thousands of variables. It won't like it and will refuse to open, and then you'll have to edit it manually in a text editor. And besides, you shouldn’t be doing this anyway because it looks ugly, and it makes you notebook difficult to read.

* Check the dtype of your numpy arrays before doing operations on them. I was in a situation where I wanted to halve all the values in an array, and reassign this to the old array. For some reason I decided to do this with a `for` loop. Even when I used `from __future__ import division` at the  start of my code, this:

   {% highlight python linenos %}

   a = np.array([1,2,3])
   for i in range(len(a)):
         a[i] = a[i]/2
   print a

   {% endhighlight %}

   returned:

   {% highlight python %}

   [0 1 1]

   {% endhighlight %}

   If I had remembered to check `a.dtype`, I would have seen that `a` was an `int64` array. I should have specified the type when I created the array, or specified at least one of the elements as a float, which would have upcast(ed?) the entire array. This leads me on to....

* Make use of numpy’s vectorisation potential. The following code is both cleaner and more [efficient](http://quantess.net/2013/09/30/vectorization-magic-for-your-computations/), and *will* return an array of floats (as long as you remember to use `from __future__ import division`) :

{% highlight python linenos %}
	
a = np.array([1,2,3])
a/2

{% endhighlight %}

* Beware of [gotchas](http://pandas.pydata.org/pandas-docs/stable/gotchas.html) in Pandas. Specifically I got tripped up by trying to convert a pandas series of dates (in unicode format) into datetime objects, using `pd.to_datetime()`. Pandas didn’t throw an error but silently refused to do what I wanted. Finally after much hair pulling and enlisting the help of a team mate, we worked out that: 

    a) if you want Pandas to throw an error when converting to datetime objects, you need to set the ‘errors’ kwarg to ‘raise’     

    b) if you want Pandas to force errors to NaT, then you need to set ‘coerce’ to True   

    c) Pandas timestamps are limited to a range of approximately [584 years](http://pandas.pydata.org/pandas-docs/stable/gotchas.html#timestamp-limitations). If you try and convert a series of dates (in string format) into a series of datetime objects, and the date range exceeds 584 years, Pandas will just refuse.  

  I think it’s fair to say that these issues were not obvious without reading the documentation.  

* If you’re really stuck, ask Stack Overflow. I spent several hours on [this problem](http://stackoverflow.com/questions/32137330/pandas-error-creating-timedeltas-from-datetime-operation) the other day. When I finally caved in and asked a question on SO (my first!) I got an answer that worked within half an hour. I still don’t know what the problem was, but at least I had a solution and could get on with my day. 

That’s it for now. If anyone has good strategies for avoiding getting stuck in a coding quagmire, I’d love to hear them.

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
