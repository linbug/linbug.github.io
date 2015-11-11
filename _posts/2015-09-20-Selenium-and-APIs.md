---
layout: post
title: Web scraping with Selenium and APIs
category: web scraping
comments: true
---

An advantage of knowing how to code is that you can build things to make your digital life better. A nice analogy I've heard is that coding is like building structures out of Lego, except you never run out of bricks.

> Remember that Lego tool you could buy to help you pry bricks apart? Imagine if you could build that tool out of Lego bricks. 
> We can use the skills we have for writing software to improve the tools we work with.

<img src="https://upload.wikimedia.org/wikipedia/commons/b/ba/Lego_tower.jpg" title="There are a lot of pictures of lego on this blog" style="height: 600px;margin: 0 auto;"/>

(from [here](http://blog.samstokes.co.uk/blog/2014/05/01/what-programming-is-like/))

-------------------------------------------------------------------------------------------------------------------

Recently, a friend asked me to build a tool for him that would take his day's points from [Fitocracy](https://www.fitocracy.com/) and log them to a goal on [Beeminder](https://www.beeminder.com/). Fitocracy gamifies exercise. You track your day's workout, be that running, swimming, or zumba (there are hundreds of obscure exercises available on the site) and Fitocracy calculates how many points you get, according to the duration and intensity of exercise. You can keep track of how many points you're getting every week, try and beat your personal best, or compete against your friends. 

<img src="https://raw.githubusercontent.com/linbug/linbug.github.io/master/_downloads/fitocracy.png" title="Fitocracy (don't judge my points)" style="margin: 0 auto;"/>


[Beeminder](https://www.beeminder.com/) is goal tracking with commitment contracts. You set a quantifiable goal (in this case, 'earn X Fitocracy points every week') and keep track of your progress on the app. If you fall off the wagon (you can define what 'the wagon' is), you pledge money not to fall off next time. If you go off track again, you pay Beeminder some money. This threat of paying a small amount of money is better than willpower alone for incentivising people to work on their goals. There's a little more complexity to it, but that's it in a nutshell.

<img src="https://raw.githubusercontent.com/linbug/linbug.github.io/master/_downloads/beeminder.png" title="Beeminder" style="margin: 0 auto;"/>

One of the coolest Beeminder functionalities in my opinion is their built-in interaction with other sites or apps. For example, you can set up Beeminder to automatically track your Github pushes, you Gmail inbox size, or your Duolingo practice (amongst other things). All of this is achieved throught the magic of APIs.

<img src="https://raw.githubusercontent.com/linbug/linbug.github.io/master/_downloads/beeminder2.png" title="Beeminder can interact with all these apps" style="margin: 0 auto;"/>

### What's an API?

An API (Application Programming Interface) is a set of commands or a 'user interface' that allows one program or website to communicate with another.

APIs are useful because you don't need to know how the underlying program/website works in order to interact with it, and the host site can give you access to just the parts they want you to have access to. The host site will also get a lot of new cool features for free, because people will build them for you. Lots of sites like Twitter, Facebook, Gmail and Spotify have APIs. [IFFT](https://ifttt.com/) is a service entirely dedicated to connecting one app to another, via APIs.

The problem is, Fitocracy don't have an API. This is annoying, as it means that as yet there is no easy way of logging things straight from Fitocracy to Beeminder. I had a go making my own solution - as you'll see I was only partially successful.

-------------------------------------------------------------------------------------------------------------------

### Why Selenium?

I used Selenium webdriver to scrape the data from Fitocracy. [Selenium](http://www.seleniumhq.org/) is a set of tools for automating browsers. Essentially, you can use Selenium to write a set of commands to open up a web page, and interact with it as a human would. Its most common use case is as a way of testing web-based applications. In my case, I'm using it to log into Fitocracy and scrape the day's points from the home page. Selenium is overkill if all you want to do is parse HTML from a page; it's also possible to scrape content from web pages using Python libraries [BeautifulSoup](http://www.crummy.com/software/BeautifulSoup/) and [Mechanize](http://wwwsearch.sourceforge.net/mechanize/). However, these require that the content you want is 'baked in' to the HTML of the page, whereas the Fitocracy content containing your day's points seems to be added via JavaScript (see [here](http://stackoverflow.com/a/17436663/41123600)).

-------------------------------------------------------------------------------------------------------------------

###FitBee

My little program is called [FitBee](https://github.com/linbug/FitBee).

I started by importing dependencies, and opening up an instance of webdriver in Chrome:

{% highlight python linenos %}

import time
from selenium import webdriver
from beeminderpy import Beeminder
driver = webdriver.Chrome(executable_path = path_to_chromedriver)

{% endhighlight %}

I need `time` for adding wait steps, `selenium` for interacting with Fitocracy and `beeminderpy` for interacting with the Beeminder API.

I then open up Fitocracy in my browser window, and login:

{% highlight python linenos %}

url = 'https://www.fitocracy.com/'
driver.get(url)
time.sleep(5)
login_xpath = '/html/body/div[2]/div/div/div[2]/a'
driver.find_element_by_xpath(login_xpath).click()
time.sleep(2)
username = driver.find_element_by_xpath('//*[@id="login-modal-form"]/div[2]/div[1]/input')
time.sleep(2)
username.send_keys(Fitocracy_username)
password = driver.find_element_by_xpath('//*[@id="login-modal-form"]/div[2]/div[2]/input')
time.sleep(3)
password.send_keys(Fitocracy_password)
time.sleep(2)
driver.find_element_by_xpath('//*[@id="login-modal-form"]/button').click()

{% endhighlight %}

Selenium lets you identify elements in the webpage via their xpath; you can grab this by using the element inspector in Chrome (and similar tools in other browsers). You can see I've liberally added wait steps in between each command, to prevent Fitocracy from thinking I'm a robot. I'm not sure if this is the best thing to do.

Next, I scrape the day's points from the Fitocracy homepage:

{% highlight python linenos %}

todays_points = driver.find_elements_by_xpath("//div/a[contains(text(),'Today')]/preceding-sibling::span")
total = 0
for today in todays_points:   
	points = today.find_elements_by_class_name("stream_total_points")[0].text
	points = int(points[:-4].replace(',', ''))
	total += points
driver.close()

{% endhighlight %}

Finally, using a [Python wrapper](https://github.com/mattjoyce/beeminderpy) for the Beeminder API, I log the points to Beeminder:

{% highlight python linenos %}

my_beeminder = Beeminder(Beeminder_authtoken)
my_beeminder.create_datapoint(
	username = Beeminder_username,
	goalname = Beeminder_goalname,
	timestamp = int(time.time()),
	value = total, 
	comment = 'Scraped from Fitocracy on ' + time.ctime())

{% endhighlight %}

Compared with the earlier complications of logging into Fitocracy and scraping the page, sending points to Beeminder via its API is beautifully simple. 

You can see my full code and documentation for this project [here](https://github.com/linbug/FitBee).

-------------------------------------------------------------------------------------------------------------------

Although this little hack works ok, it's not optimum. Selenium opens a browser window every time and loads all the elements, which is slow and unnecessary, since we don't need to watch what it's doing. Memory-wise and stylistically, a [headless](https://en.wikipedia.org/wiki/Headless_browser) browser instance (without a graphical interface) would be preferable. I tried making my browser headless using [PhantomJS](http://phantomjs.org/), but ran into issues which I still haven't resolved (see [here](http://stackoverflow.com/questions/32521196/phantomjs-cannot-find-an-element-where-chromedriver-can) and [here](http://stackoverflow.com/questions/32629265/use-phantomjs-evaluate-function-from-within-selenium)). This is an ongoing project - if you can help with my headless issues please get in touch!

<iframe src="//giphy.com/embed/lmIqAkw7nfBm0" width="480" height="247" frameBorder="0" class="giphy-embed" allowFullScreen></iframe>

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