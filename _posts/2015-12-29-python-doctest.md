---
layout: post
title: Python doctest
categories: []
tags: [coding, Python]

---

I recently learned about doctest in Python, and now I'm excited and want to use it for everything.

[doctest](https://docs.python.org/2/library/doctest.html) is a module that lets you write tests within your docstrings. When you run the file as a script, these tests run; if they fail, you'll get a printout of which tests failed. This is useful for making sure that your docstrings are up to date after you've modified your code.

Here's an example. Let's say I'm writing a script with some simple functions in it:

{% highlight python linenos %}

def salutation(name):
    print("Hello {}!".format(name))

def double(number):
    print(2 * number)

def add_three(number):
    number += 3
    print(number)

{% endhighlight %}


In order to use doctest, I'll write some tests in the docstrings:

{% highlight python linenos %}

def salutation(name):
    '''
    Greets the user.

    >>> salutation('Lin')
    Hello Lin!
    '''
    print("Hello {}!".format(name))

def double(number):
    '''
    Doubles the input.

    >>> double(5)
    10
    '''
    print(2 * number)

def add_three(number):
    '''
    Adds 3 to the input.

    >>> add_three(2)
    5
    '''
    number += 3
    print(number)

{% endhighlight %}

Notice that `>>> ` signifies where a python code snippet starts (like in an interactive session). Lines that come directly after without the `>>> ` are the expected result. Now we just need to add the following lines to the bottom of the script:

{% highlight python linenos %}

if __name__ == "__main__":
    import doctest
    doctest.testmod()

{% endhighlight %}

Here you can see that whenever we run the file as a script, `if __name__ == "__main__"` evaluates to True (I wrote about this briefly [here](http://linbug.github.io/2015/12/12/week-5---python-pairing-planigale/)). We then import the `doctest` module,  and execute doctest's `testmod()` function. `testmod()` goes through all of the docstrings in the script and attempts to execute all of the code snippets it finds. If all of our expected values match the computed values (as in this case), doctest won't give us any output. However, let's say I went back and changed a couple of my functions:

{% highlight python linenos %}

def salutation(name):
    '''
    Greets the user.

    >>> salutation('Lin')
    Hello Lin!
    '''
    print("Bye {}!".format(name))

def double(number):
    '''
    Doubles the input.

    >>> double(5)
    10
    '''
    print(3 * number)

def add_three(number):
    '''
    Adds 3 to the input.

    >>> add_three(2)
    5
    '''
    number += 3
    print(number)

if __name__ == "__main__":
    import doctest
    doctest.testmod()

{% endhighlight %}

Now if I run the script again, I get this output in my terminal:

{%highlight bash%}

**********************************************************************
File "python_doctest.py", line 14, in __main__.double
Failed example:
    double(5)
Expected:
    10
Got:
    15
**********************************************************************
File "python_doctest.py", line 5, in __main__.salutation
Failed example:
    salutation('Lin')
Expected:
    Hello Lin!
Got:
    Bye Lin!
**********************************************************************
2 items had failures:
   1 of   1 in __main__.double
   1 of   1 in __main__.salutation
***Test Failed*** 2 failures.

{% endhighlight %}

We can see how many failures we had and which functions failed.

doctest is great for keeping your docstrings accurate, and it's best practice to write a docstring for every function and class. However, docstring is unwieldy if you want to do any significant testing (it's annoying for your user to have to read long docstrings with loads of edge cases). For more significant testing, you can use the [unittest](https://docs.python.org/3/library/unittest.html) module.

