A while ago, I needed to upload a directory of files to S3 via a unix command. There were several thousand files to upload, and each on took about half a second. It was taking a long time, and I was impatient. Waiting for things is boring! So when my colleague showed me how to parallelise the process by refactoring my bash script to include an `&`, making the process go much faster, I thought this was pretty cool.

This made me curious to understand what was actually happening here, and how I could exploit similar concepts in Python to make my code run faster.

*TLDR: if you already know about concurrency and multiprocessing and just want to know about Python libraries for doing these things, skip to the Python section below*.

# What is parallelisation?

A lot of the time people use 'parallelisation' or 'parallel computing' as generic umbrella terms to describe everything related to doing computation through simultaneous activity. 

However, not all parallel computing is done in the same way. The broadest distinction is between two main types of parallel computing,  **concurrency** and **multiprocessing**.

## Concurrency and multiprocessing

Concurrency and multiprocessing refer to two very different ways of doing simultaneous work.

An analogy I came up with to explain the difference between these two concepts is a line of people queuing with their groceries at the supermarket. Each person has a certain amount of shopping to scan through the till. In the first scenario, everyone waits in a single line and has their shopping scanned through the till by the assistant one after the other.

[picture of supermarket]

### Concurrency
The first scenario works fine, but it's slow. Sometimes there are pauses which cause bottlenecks. Maybe someone forgot avocadoes for their guacamole, so everyone in the line has to wait while they go and find them (how selfish!). During this pause, instead of waiting (as he did in scenario one), the till assistant starts scanning some items from the other customers. When the first customer returns with her avocadoes, the assistant resumes from where he was before. 

This is how *concurrency* works. 

[avocado of regret]

*Concurrency* is when two or more tasks are being performed during overlapping time periods, but they're never being executed at exactly the same time. A real-world example would be a computer with a single core that is running multiple drivers for the mouse, keyboard and display driver at the same time. The computer isn't ever running more than one process; rather, it sneakily switches between them so fast that you don't notice the gaps. 

This way, if one of the units of work is super slow, it doesn't mean all the others have to queue patiently before they can start; they can proceed in synchrony. Concurrency relies on the fact that processes can be broken down into discrete units (in some contexts these are called 'threads'), which can be run in any order without affecting the final output.

### Multiprocessing
Back to the supermarket. Another thing that could happen when the queue gets too long is that they call up another shop assistant and open another till. Now the customers that were previously being served by one assistant are served by two. 

This is how *multiprocessing* works.

<img src="https://raw.githubusercontent.com/linbug/linbug.github.io/master/_downloads/parallel_lines.JPG" title="multiple checkout lines in parallel" style="height: 400px;margin: 0 auto;"/>

*Multiprocessing* is bona fide parallelism (sometimes it's just called 'parallelism') because at least two processes are being performed in parallel, at the same time. In practice this requires the individual pieces of computation to be performed on different CPUs on your machine (or on different machines entirely).

In other words, you could have hundreds of *concurrent* processes happening on just one core, but for *multiprocessing* you need multiple cores.

## Sounds great. Can I do parallelisation in Python?
You you can, but it's not as trivial to implement as in other languages.

Python (in particular CPython rather than say, Jython or IronPython) has something called the **Global Interpreter Lock** (GIL), which (for safety reasons) forces only one thread to be executed at a time. 

The GIL's effects on the threads of your program is simple: ['One thread runs Python, while N others sleep or await I/O'](https://opensource.com/article/17/4/grok-gil). This makes performing multi-threading in Python as you would in other languages really difficult. It _is_ possible to have control over the GIL if you write an Python library coded in C, but the prospect of that brings me out in a cold sweat. What's worse, the GIL is pretty much baked into CPython; removing it is really hard (so hard that it's been described as [Python's hardest problem](https://jeffknupp.com/blog/2012/03/31/Pythons-hardest-problem/)).

But don't hate the GIL! Without it, the implementation of the CPython interpreter and C extensions would be much more complicated. We have the GIL to thank for much-loved C libraries such as NumPy and SciPy, which are some of the main reasons why Python is so popular as a data processing language.

### Threads versus processes
Before looking at Python libraries, I'll briefly mention the difference between a *thread* and a *process*, since these feature a lot in discussions about parallelisation.

A *process* is an instance of a computer program being implemented, whereas a *thread* is a subset of a process.

The threads within a process share resources such as memory space; this means that if there is a variable within a process' memory, it's accessible to all the threads in that process. 

Different processes don't share the same memory space, so if they want to know what another one is thinking, they have to talk to one another. This can be expensive, so you probably want to avoid it if possible.

# Python modules for parallelisation
There are two main Python modules for doing parallelisation, `threading` and `multiprocessing`, and also many others besides.

## `threading`
As I already said, the GIL prevents two or more Python threads from executing at the same time. This is great for preventing threads from accidentally overwriting each others' memory (moar [here](https://opensource.com/article/17/4/grok-gil)), but it means that we can only parallelise using Python threads in certain situations. 

In what situations should you use the Python `threading` module? Let's say you are writing a program that is I/O limited (the time taken to complete an operation is limited by input/output operations). For example, you are fetching URLs by making requests over HTTP, and there are times when you are waiting for a response. If you could exploit these pauses to do other useful work, the overall time that your program takes to run will be shorter. 

This is where threading comes in. In Python, if there is an I/O block, Python handily releases the GIL while waiting for the I/O block to resolve. In these situations there's no pesky GIL preventing concurrent thread execution. Woohoo! So if you're doing a lot of I/O bound operations, threading can be useful to make your programs' execution more responsive.

Here is a toy example of how you could create threads to make HTTP requests. Note that `time.sleep` also blocks the GIL, so we can use it to simulate a longer I/O block.

{% highlight Python %}
import threading
import time

import requests


urls = [
  'https://pymotw.com/2/threading/',
  'http://chriskiehl.com/article/parallelism-in-one-line/',
  'https://stackoverflow.com/questions/3044580/multiprocessing-vs-threading-Python',
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
Opening https://pymotw.com/2/threading/
Thread-2 starting
Opening http://chriskiehl.com/article/parallelism-in-one-line/
Thread-3 starting
Opening https://stackoverflow.com/questions/3044580/multiprocessing-vs-threading-Python
Thread-3 exiting
Thread-2 exiting
Thread-1 exiting

{% endhighlight %}

You can see that as one thread is waiting, another is spawned.

The whole syntax of instantiating a thread inside a for loop and passing in the arg is a bit unwieldy. Fortunately, there's a nicer syntax set out [in this great blog post](http://chriskiehl.com/article/parallelism-in-one-line/) involving a thread pool. The module `multiprocessing` (more on this below) has a `multiprocessing.dummy` module that has the exact same API as `multiprocessing` but uses threads instead of processes.

The thread pool has a handy `map` function that does just what you'd expect, except it makes the function calls concurrently:

{% highlight Python %}

import multiprocessing.dummy as dummy
import time

import requests


urls = [
  'https://pymotw.com/2/threading/',
  'http://chriskiehl.com/article/parallelism-in-one-line/',
  'https://stackoverflow.com/questions/3044580/multiprocessing-vs-threading-Python',
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

This produces:

{% highlight bash %}

Thread-2 starting
Opening https://pymotw.com/2/threading/
Thread-3 starting
Opening http://chriskiehl.com/article/parallelism-in-one-line/
Thread-1 starting
Opening https://stackoverflow.com/questions/3044580/multiprocessing-vs-threading-Python
Thread-2 exiting
Thread-1 exiting
Thread-3 exiting

{% endhighlight %}

This syntax is much cleaner and also has the advantage of giving me easy access to the results at the end.

## `multiprocessing`
Threading is good for making your program run faster if it's blocked by I/O operations. However, if your bottleneck is that your code is computationally expensive to run (it's CPU-bound) then threading isn't going to cut it. This is where you'll need `multiprocessing`. 

In contrast to `threading`, the `multiprocessing` module spawns new processes with separate GILs. This means that you can get around the threading issues and take advantage of multiple CPUs and cores. However, as I already mentioned it's more difficult and more expensive to share data between processes than between threads, so if you're going to be doing this you might not want to run lots of processes at once or to create and destroy them frequently.

Again, we can use the mapping pattern. The API for `multiprocessing` is almost exactly the same as above.

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

## What else?
The above are the two obvious libraries that people talk about when they talk about parallelisation in Python. There's a couple more that I've heard about that I'll cover briefly here.

### `concurrent.futures`
`concurrent.futures` is part of the standard library, and lets you do threading and multiprocessing via the `ThreadPoolExecutor` and `ProcessPoolExecutor` classes. 

Like the examples above for the `multiprocessing` module, they let us create pools of threads or processes with a set number of workers, which we can submit tasks to. The pool takes care of distributing the tasks and scheduling.

Unlike the `multiprocessing` module, when we submit a task to the pool, we get back an instance of the `Future` class. A `Future` instance represents a deferred computation that may or may not have completed yet. Futures have a `done` method that we can call to check whether the command has finished executing or not, but the typical pattern to use would be to use the `add_done_callback` method to notify the client code when the future is done executing. 

{% highlight python %}
from concurrent.futures import ThreadPoolExecutor
import time

import requests


urls = [
	'https://pymotw.com/2/threading/',
	'http://chriskiehl.com/article/parallelism-in-one-line/',
	'https://stackoverflow.com/questions/3044580/multiprocessing-vs-threading-python',
]

def open_url(url):
	time.sleep(3)
	return requests.get(url)

with ThreadPoolExecutor(max_workers=5) as pool:
	results = pool.map(open_url, urls)

{% endhighlight %}

This time I used a context manager to take care of the cleanup, but otherwise it's almost the same syntax as the `multiprocessing` example above. In fact, under the covers, `ProcessPoolExecutor` is using the `multiprocessing` module.

So why would you use `concurrent.futures` over `threading` or `multiprocessing`? Reasons include: 
- you get access to both threading and multiprocessing abilities in one library
- it has a simpler interface, so is easier to use. 

More about this [here](https://stackoverflow.com/questions/20776189/concurrent-futures-vs-multiprocessing-in-python-3).

### `async.io`
`async.io` is apparently really hot right now. 

Like `threading` and `concurrent.futures`, it is a package that implements concurrency. 

Also like `concurrent.futures`, Futures form the foundation of the `async.io` package.

However, unlike any of the packages mentioned previously, it uses coroutines to do this. A coroutine in this context is a generator that receives values from an event loop. I took a look at ayncio in Fluent Python and [this blog post](http://lucumr.pocoo.org/2016/10/30/i-dont-understand-asyncio/), and it looks enormously complicated to use. It looks like something you'd only want to use if you really know what you're doing.
