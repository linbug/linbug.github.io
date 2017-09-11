# You too can parallelise in Python

<iframe src="https://giphy.com/embed/xJTCqNhOU5mwg" width="480" height="229" frameBorder="0" class="giphy-embed" allowFullScreen></iframe>

Parallelisation in Python has a bad rep, so much so that I've been put off learning about it. However, sometimes in my work I come up against [embarrassingly parallel problems](https://en.wikipedia.org/wiki/Embarrassingly_parallel): problems that should be very easy to parallelise.  Parallel programming is also a hot topic at the moment as a way to increase performance without increasing CPU power. Also, Python's parallel programming libraries are maturing with each new release. It seems like a good time to get familiar with these concepts.

This post will start off with a brief introduction into what parallel programming is, and then describe some of the libraries you can use to do this in Python.

# What is parallelisation?

A lot of the time people use 'parallelisation' or 'parallel computing' as generic umbrella terms to describe everything related to doing computation through simultaneous activity.

However, not all parallel computing is done in the same way. The broadest distinction is between two main types of parallel computing,  **concurrency** and **multiprocessing**.

## Concurrency versus multiprocessing

Concurrency and multiprocessing refer to two very different ways of doing simultaneous work. Concurrency describes interleaving execution of the tasks in the same timeframe, whereas multiprocessing involves adding more workers to do the tasks.

An analogy I came up with to explain the difference between these two concepts is a line of people queuing with their groceries at the supermarket. Each person has a certain amount of shopping to scan through the till. In the first scenario, everyone waits in a single line and has their shopping scanned through the till by the assistant one after the other. This is like an unparallelised job.

<img src="https://raw.githubusercontent.com/linbug/linbug.github.io/master/_downloads/groceries.jpg" title="checkout" style="height: 400px;margin: 0 auto;"/>


### Concurrency
The first scenario works fine, but it's slow. Sometimes there are pauses which cause bottlenecks. Maybe someone forgot avocadoes for their guacamole, so everyone in the line has to wait while she goes and finds them (how selfish!). In scenario two, instead of waiting during this pause (as he did in scenario one), the till assistant starts scanning some items from the other customers. When the first customer returns with her avocadoes, the assistant resumes from where he was before. This is like how *concurrency* works.

*Concurrency* is when two or more tasks are being performed during overlapping time periods, but they're never being executed at exactly the same time. A real-world example would be a computer with a single core that is running multiple drivers for the mouse, keyboard and display driver at the same time. The computer isn't ever running more than one process at a time; rather, it sneakily switches between them so fast that you don't notice the gaps.

This way, if one of the units of work is super slow, it doesn't mean all the others have to queue patiently before they can start; they can proceed in synchrony. Concurrency relies on the fact that processes can be broken down into discrete units (in some contexts these are called 'threads'), which can be run in any order without affecting the final output.

### Multiprocessing
Back to the supermarket. Another thing that could happen when the queue gets too long is that they call up another shop assistant and open another till. Now the customers that were previously being served by one assistant are served by two. This is like how *multiprocessing* works.

<img src="https://raw.githubusercontent.com/linbug/linbug.github.io/master/_downloads/parallel_lines.JPG" title="multiple checkout lines in parallel" style="height: 400px;margin: 0 auto;"/>

*Multiprocessing* is bona fide parallelism (sometimes it's just called 'parallelism') because at least two processes are being performed in parallel, at the same time. In practice this requires the individual pieces of computation to be performed on different CPUs on your machine (or on different machines entirely).

In other words, you could have hundreds of *concurrent* processes happening on just one core, but for *multiprocessing* you need multiple cores. 

Note that if you start reading around about this topic, you'll find people saying that multiprocessing is trivial to implement whereas concurrency is really hard; it's been decribed by [Dave Beazley](http://www.dabeaz.com/) as 'one of the most difficult topics
in computer science (usually best avoided)'. It seems to me that when people say this they are referring specifically to multi-threaded code, whereas there are lots of alternative architectures to this that you can use to implement concurrency. You can read about some of them in [Seven Concurrency Models in Seven Weeks](https://pragprog.com/book/pb7con/seven-concurrency-models-in-seven-weeks) (it also looks like it's a good intro to parallel programming architectures in general).

## Sounds great. Can I do parallelisation in Python?
Yes you can, but it's not as trivial to implement as in other languages.

Python (in particular CPython rather than say, Jython or IronPython) has something called the **Global Interpreter Lock** (GIL), which (for safety reasons) forces only one thread to be executed at a time.

The GIL's effects on the threads of your program is simple: ['one thread runs Python, while N others sleep or await I/O'](https://opensource.com/article/17/4/grok-gil). This makes performing multi-threading in Python as you would in other languages really difficult. It _is_ possible to have control over the GIL if you write an Python library coded in C, but the prospect of that brings me out in a cold sweat. What's worse, the GIL is pretty much baked into CPython; removing it is really hard (so hard that it's been described as [Python's hardest problem](https://jeffknupp.com/blog/2012/03/31/pythons-hardest-problem/)).

But don't hate the GIL! Without it, the implementation of the CPython interpreter and C extensions would be much more complicated. We have the GIL to thank for much-loved C libraries such as NumPy and SciPy, which are some of the main reasons why Python is so popular as a data processing language.

### Threads versus processes
Before looking at Python libraries, I'll briefly mention the difference between a *thread* and a *process*, since these feature a lot in discussions about parallelisation.

A *process* is an instance of a computer program being implemented, whereas a *thread* is a subset of a process.

The threads within a process share resources such as memory space; this means that if there is a variable within a process' memory, it's accessible to all the threads in that process.

Conversely, different processes don't share the same memory space, so if they want to know what another one is thinking, they have to talk to one another. This can be an expensive operation to perform, so it's better to avoid it if you can.

# Python modules for parallelisation
I'll talk about four Python libraries for doing parallelisation: `threading`, `multiprocessing`, `concurrent.futures` and `aync.io`. There are others (such as [`Twisted`](https://twistedmatrix.com/trac/), [`Tornado`](http://www.tornadoweb.org/en/stable/), and [`Celery`](http://www.celeryproject.org/)) but these four are in the standard library, and as far as I can see they represent pretty well the main kinds of architecture  for parallelisation that exist in Python. 

## `threading`
Using multiple threads to execute work is a form of concurrency. As I already said, In Python the GIL prevents two or more Python threads from executing at the same time. This is great for preventing threads from accidentally overwriting each others' memory (moar [here](https://opensource.com/article/17/4/grok-gil)), but it means that we can only parallelise using Python threads in certain situations.

In what situations should you use the Python `threading` module? Let's say you are writing a program that is I/O limited (the time taken to complete an operation is limited by input/output operations). For example, you are fetching URLs by making requests over HTTP, and there are times when you are waiting for a response. If you could exploit these pauses to do other useful work, the overall time that your program takes to run will be shorter.

This is where threading comes in. In Python, if there is an I/O block, Python handily releases the GIL while waiting for the I/O block to resolve. In these situations there's no pesky GIL preventing concurrent thread execution. Woohoo! So if you're doing a lot of I/O bound operations, threading can be useful to make your programs' execution more responsive.

Here is a toy example of how you could create threads to make HTTP requests. Note that `time.sleep` also blocks the GIL, so we can use it to simulate a longer I/O block.

{% highlight Python %}
import threading
import time

import requests


urls = [
  'https://www.royalacademy.org.uk/',
  'http://www.metmuseum.org/',
  'http://www.artic.edu/',
]

def open_url(url):
  print(threading.current_thread().getName(), 'starting')
  print('Opening {}'.format(url))
  time.sleep(3)
  requests.get(url)
  print(threading.current_thread().getName(), 'exiting')

if __name__ == '__main__':
    for url in urls:
        t = threading.Thread(target=open_url, args=(url,))
        t.start()

{% endhighlight %}

This outputs the following in your terminal:

{% highlight bash %}

Thread-1 starting
Opening https://www.royalacademy.org.uk/
Thread-2 starting
Opening http://www.metmuseum.org/
Thread-3 starting
Opening http://www.artic.edu/
Thread-3 exiting
Thread-2 exiting
Thread-1 exiting

{% endhighlight %}

You can see that as one thread is waiting, another is spawned.

The whole syntax of instantiating a thread inside a `for` loop and passing in the arg is a bit unwieldy. Fortunately, there's a nicer syntax set out [in this great blog post](http://chriskiehl.com/article/parallelism-in-one-line/) involving mapping tasks over a thread pool. 

A thread pool is a [pool of workers](https://docs.python.org/2/library/multiprocessing.html#using-a-pool-of-workers) that you can create and offload tasks to all at once. Unfortunately, you can't make Pool instances with `threading`.  However, you _can_ using [`multiprocessing.dummy`](https://docs.python.org/2.7/library/multiprocessing.html#module-multiprocessing.dummy), which replicates the `multiprocessing` API (more on this below) but uses `threading` under the covers (i.e. it uses threads instead of processes).

The pool instance has a handy `map` function that does just what you'd expect, except it makes the function calls concurrently:

{% highlight Python %}

import multiprocessing.dummy as dummy
import time

import requests


urls = [
  'https://www.royalacademy.org.uk/',
  'http://www.metmuseum.org/',
  'http://www.artic.edu/',
]

def open_url(url):
  print(dummy.current_process().name, 'starting')
  print('Opening {}'.format(url))
  time.sleep(3)
  print(dummy.current_process().name, 'exiting')
  return requests.get(url)

if __name__ == '__main__':
    pool = dummy.Pool(3)

    results = pool.map(open_url, urls)

    pool.close()
    pool.join()

{% endhighlight %}

This syntax is much cleaner and also has the advantage of giving me easy access to the results at the end.

## `multiprocessing`
Threading is good for making your program run faster if it's blocked by I/O operations. However, if your bottleneck is that your code is computationally expensive to run (it's CPU-bound) then threading isn't going to cut it. This is where you'll need `multiprocessing`.

In contrast to `threading`, the `multiprocessing` module spawns new processes with separate GILs. This means that you can get around the threading issues and take advantage of multiple CPUs and cores. However, as I already mentioned it's more difficult and more expensive to share data between processes than between threads.

Again, we can use a pool of workers and the mapping pattern. The API for `multiprocessing` is very similar to `threading`:

{% highlight Python %}

from multiprocessing import Pool

list_to_be_processed = range(10000)

def multiply_number_by_itself(number):
return number**number

if __name__ == '__main__':
    pool = Pool()
    results = pool.map(multiply_number_by_itself, list_to_be_processed)
    pool.close()
    pool.join()

{% endhighlight %}


If you call `top` from your bash terminal you can see a list of your system processes. When I run the script, I can see nine Python3 processes pop up. By default `Pool()` will create as many processes as you have cores, and I have eight cores on my machine. The ninth must be the original Python process that existed before.

## `concurrent.futures`
`concurrent.futures` is part of the standard library that was added in Python 3.2, and lets you do _both_ threading and multiprocessing via the `ThreadPoolExecutor` and `ProcessPoolExecutor` classes.

Like the examples above for `multiprocessing` and `multiprocessing.dummy`, they let us create pools of threads or processes with a set number of workers, which we can submit tasks to. The pool takes care of distributing the tasks and scheduling.

Unlike `multiprocessing`, when we submit a task to the pool, we get back an instance of the `Future` class. A `Future` instance represents a deferred computation that may or may not have completed yet. Futures have a `done` method that we can call to check whether the command has finished executing or not, but the typical pattern to use would be to use the `add_done_callback` method to notify the client code when the future is done executing. The result of this task might be an exception. See the [PEP that introduced futures](https://www.python.org/dev/peps/pep-3148/) for more information. 

{% highlight python %}
from concurrent.futures import ThreadPoolExecutor
import time

import requests


urls = [
    'https://www.royalacademy.org.uk/',
    'http://www.metmuseum.org/',
    'http://www.artic.edu/',
]

def open_url(url):
    time.sleep(3)
    return requests.get(url)

if __name__ == '__main__':
    with ThreadPoolExecutor(max_workers=5) as pool:
        results = pool.map(open_url, urls)

{% endhighlight %}

This time I used a context manager to take care of the cleanup, but otherwise it's almost the same syntax as the `multiprocessing` example above. In fact, I looked at the source code and saw that under the hood `ProcessPoolExecutor` is using `multiprocessing` module, and `ThreadPoolExecutor` is using `threading`.

So why would you use `concurrent.futures` over `threading` or `multiprocessing`? Reasons include:

- you get access to both threading and multiprocessing abilities in one library
- it has a simpler interface, so is easier to use

Reasons you might not:

- The API is more limited, so you can't do as much as you can with `multiprocessing` or `threading`
- If you're using Python 2.7 or earlier you'll have to use a backport of `concurrent.futures`

[In general, the advice seems to be](https://stackoverflow.com/questions/20776189/concurrent-futures-vs-multiprocessing-in-python-3) to use `concurrent.futures` if you can, since it's intended to mostly replace `multiprocessing` and `threading` in the long-term.

## `async.io`
`async.io` is apparently really hot right now. It's part of the standard library from Python 3.4 onwards. Luciano Ramalho in [Fluent Python](http://shop.oreilly.com/product/0636920032519.do) describes it as 'one of the largest and most ambitious libraries ever added to Python'.

Like `threading` and `concurrent.futures`, it is a package that implements concurrency. Also like `concurrent.futures`, Futures objects form a foundation of the `async.io` package. However, unlike any of the packages mentioned previously, `async.io` uses some different contructs (**event loops** and **coroutines**) to implement a completely different concurrency architecture.

- An [event loop](https://docs.python.org/dev/library/asyncio-eventloop.html) is a general computer science construct for something which manages and distributes the execution of different tasks. It waits for events from an event provider and dispatches them to an event handler. An example might be the main loop in a program that is continually testing for whether the user has interacted with the user interface.

- A [coroutine](https://docs.python.org/3/library/asyncio-task.html) is a Python contruct that is an extension to a generator. How they work is beyond the scope of this post (there's a whole chapter dedicated to them in Fluent Python if you want to learn more, and [this](http://www.dabeaz.com/coroutines/Coroutines.pdf) is an interesting and funny slide deck about them), but just know that where a **generator only generates values, a coroutine can consume them** - i.e. you can send values to a coroutine. As such, they are able to receive values from an event loop.  Importantly, you can use coroutines instead of threads to implement concurrent activities.

The key difference to how `async.io` works compared tp `threading` is that it uses a main event loop to drive coroutines that are executing concurrent activities, and it does so *with a single thread of execution*. Where `threading` cycles between threads in order to see whether they're still blocked, `asyncio` uses the event loop to keep track of and schedule all the coroutines that want time on the thread.

One tricky thing with `asyncio` is that you can't necessarily just use the same libraries that you would normally use synchronously, because they can block the event loop. You instead have to use special aync versions of the libaraies. For example, I use the `requests` library above to fetch web content over HTTP, but if I was using `asyncio` I'd have to use something like [`aiohttp`](https://github.com/aio-libs/aiohttp).

I've been looking at the PEPs that were included in Python 3.5 and 3.6, and looks like you can now use [coroutines with a different syntax](https://www.python.org/dev/peps/pep-0492/) and [asynchronous versions of list, set, dictionary comprehensions](https://www.python.org/dev/peps/pep-0530/) , as well as [generators](https://www.python.org/dev/peps/pep-0525/). There's also plans for formalising new keywords related to asynchronous programming `async` and `await` in Python 3.7. Clearly developing these features is a priority right now, and the `async.io` ecosystem is maturing rapidly to keep pace with developments in other languages. 

I _really_ tried to put together an equivalent example here showing how `async.io` works like the other above. I came up with something that kinda sorta works but I don't understand what it's doing. There are a lot of new concepts to take in with `asyncio` and I'm struggling to understand how they all fit together. [It looks like I'm not the only one](http://lucumr.pocoo.org/2016/10/30/i-dont-understand-asyncio/). Instead of trying to explain something I don't understand, I'm going to admit defeat at this point. Maybe I'll revisit `async.io` at a later date.

If, unlike me, you can figure out how to use it, when should you use `async.io` over `concurrent.futures` or `threading`? According to [this person](http://masnun.rocks/2016/10/06/async-python-the-different-forms-of-concurrency/), `async.io` is better if your I/O-bound operation is low and has many connections. This is because `async.io` specifically keeps track of which coroutines are ready and which are still awaiting I/O. So `async.io` incurs fewer switching costs than `threading` might do. 

# Summary

- In summary, if you're doing work that is I/O-limited you need concurrency, whereas if you're CPU-limited you need parallelisation. In Python you can achieve concurrency either using threads or using coroutines and event loops.
- If you're doing something pretty standard and can get away with using `concurrent.futures`, look no further.
- If you need finer control and a richer API, use `multiprocessing` or `threading`.
- If you are doing I/O with lots of connections (and really know what you're doing) use `async.io` 
