---
layout: post
title: Thanksgiving tweets
categories: []
tags: []
comments: true
---

This week, I've been exploring scraping tweets using Twitter's API. I wrote previously about APIs [here](http://linbug.github.io/web%20scraping/2015/09/20/Selenium-and-APIs/).

Twitter has two kinds of API: [REST APIs](https://dev.twitter.com/rest/public) and [Streaming APIs](https://dev.twitter.com/streaming/overview) (they also have [ADs APIs](https://dev.twitter.com/ads/overview) but I'm ignoring them):

- The REST APIs are used for programmatically reading and writing to Twitter e.g. you might use them to write a new tweet, or read follower data.

- The Streaming APIs give you 'low latency' (read - essentially real-time) access to the live stream of tweets. Using the Streaming APIs feels like siphoning off water from a firehose - you set up a streaming connection with Twitter that will *keep giving you fresh tweets until you shut it off*. The Streaming APIs are much better suited to data mining, as you can use them to grab a high volume of tweets.

I used the Streaming API to pull public tweets, filtering according to various keywords. There are lots of Python wrappers for the twitter APIs; I used [tweepy](http://www.tweepy.org/).

Using the Twitter API first requires you to register an application with them, so that you can get the Consumer Key, Consumer Secret, and Access Tokens required for [OAuth](https://dev.twitter.com/oauth/overview/faq) authentication (a prereq for accessing the API).

I modified a short [python script](https://github.com/linbug/TwitScrip/blob/master/twitterscrape.py) for setting up the connection to Twitter and filtering the stream. The tweets are delivered back to you in multiple JSON files. An important thing to note is that Twitter will only give you a 1% 'statistically relevant' sample of the total tweets; if you want to grab 100% the tweets for a given filter, you need [special permission](https://dev.twitter.com/streaming/reference/get/statuses/firehose).

## thanksgiving
Since it was Thanksgiving this week, I was interested to do some analysis on what people eat for this holiday. Obviously, we don't celebrate TG in the UK, so I thought it would be an interesting cultural exercise to see what kinds of holiday foods people talk about on Twitter; my impression is that Thanksgiving is about eating traditional winter fare like turkey, mashed potatoes, cranberries, and pumpkin pie, but that sometimes people go off piste and eat things like Mexican food.

On the day before Thanksgiving at around 3pm, I set up my connection to Twitter and collected tweets from the streaming API that contained both the hashtags '#thanksgiving' and '#food', for about 5 minutes.  My original plan was to tokenise all of the word in a tweet, and then check each of these against a database of common food names to pull out just the food words. Unfortunately, this turned out to be harder than I thought, since I couldn't manage to find a suitable food name database (the ones that exist tend to be for calorie counting, and so are very specific: think 'Papa Joe's Gluten-free chocolate cake mix').

Abandoning my original plan (for the time being), I instead had a look at the kinds of hashtags that are associated with '#thanksgiving' and '#food'. After separating out the hashtags from the text data, I saw that the vast majority of hashtags in my sample of 983 tweets only appeared once:

<img src="https://raw.githubusercontent.com/linbug/linbug.github.io/master/_downloads/tweet_counts.png" title="How often hashtags appear" style="height: 500px;margin: 0 auto;"/>

This is to be expected; my sample size is small and there's an infinite number of possible hashtags (well, I suppose the upper bound for a hashtag length is 139 characters, so not counting special characters, there would actually be \\(26^{139}\\) possible permutations). The interesting hashtags are the ones that get referenced more than once. Here are the hashtags in my sample that were referenced more than once, ordered from most to least frequent (I removed any hashtags that contained #thanksgiving or #food, since these would have been included in the original search):

<img src="https://raw.githubusercontent.com/linbug/linbug.github.io/master/_downloads/hashtag_counts.png" title="Hashtags and their frequencies" style="margin: 0 auto;"/>

The most frequent hashtag is #recipe, followed by #turkey. Then there's a few that don't make sense to me - #teamchris, #twitchpartnership and #sunbeltbakery. I think what's happening here is that several people are retweeting a tweet, and that's skewing the hashtag frequencies (I checked the tweet IDs, and none of them seemed to have been accidentally duplicated). I need to figure out how (and whether it's appropriate) to exclude tweets that are retweets. According to these hashtags, foods that people like to eat on Thanksgiving include #pie, #pumpkinpie, #pecanpie, #stuffing, #mashedpotatoes,  and #yams. They also like to eat food that is #healthy, #organic and #vegetarian.

Ok, so this isn't earth-shattering but it got me into the swing of using and cleaning Twitter data. Something that I noticed when I was doing the scraping was that you get a teeny sense of the magnitude of humanity when you see how fast your text file increases in size as the tweets roll in. See [here](https://github.com/linbug/TwitScrip/blob/master/Cleaning_twitter_data.ipynb) for the ipython notebook of my analyses.

---------------------------------------------------------------------------------------------

## What's next

I'd like to do something a bit more sophisticated with twitter data. Some ideas I've had are:

- do some kind of network analysis to see how tweets/retweets are connected between users, or users to other users.
- do some kind of geographical analysis/visualisation of tweets (although [<2% of tweets](http://dfreelon.org/2013/05/12/twitter-geolocation-and-its-limitations/) have a geolocation).
- use sentiment analysis to see how public mood changes over the course of a day.

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

