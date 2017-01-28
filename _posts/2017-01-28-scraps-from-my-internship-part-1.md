---
layout: post
title: 'Scraps from my internship part 1: programming concepts' 
categories: [Python, programming, Enthought]
comments: true
---

I am so behind with my blog that I haven't even gotten round to talking about [Enthought](https://www.enthought.com/) yet, where I interned from September last year until a couple of weeks ago. Enthought write scientific software as well as running programming training courses. They do almost everything in Python, and there are some exceptionally skilled Pythonistas working there. 

I actually originally learned Python using [Enthought's training videos and exercises](https://training.enthought.com/), so it was very cool to get to work there. For my internship I worked on adding a new feature to the [Canopy Geoscience](https://www.enthought.com/products/canopy-geoscience/) application, a piece of software that helps geoscience researchers analyse their data. 

I tried to keep a list of new concepts/tools as I came across them during the course of the internship. Rather than blog about the project I thought I'd jumble together some things I learned. Enthought very kindly gave me a copy of [Fluent Python](http://shop.oreilly.com/product/0636920032519.do) as a going away gift, so I've referenced it a few times here; it's a very good book.

This was threatening to turn into a monster essay so I've decided to break it down into three separate posts:

1. Programming concepts

2. Python specifics

3. Git tricks

Read on for part 1!

## Part 1: Programming concepts

### Navigating a huge codebase

The hardest thing I found about my project was learning how to work with a big codebase. I imagined the codebase like a big and complex mechanism, with lots of interconnecting cogs, cams and pulleys. A bit like the inside of this watch:

<img src="https://raw.githubusercontent.com/linbug/linbug.github.io/master/_downloads/mechanism.jpg" style="height: 20em;margin: 0 auto;"/>
<p class="captions"><a href="https://www.flickr.com/photos/alexbrn/5035170693/">Watch mechanism</a> by Alex Brown</p> 

(Although unlike a watch, codebases tend to be sprawling and idiosyncratic, more like an organism that evolved over time than an elegant piece of machinery, so they are rarely neat and predictable. Anyway.)

I didn't need to be intimately *au fait* with each and every part of the mechanism to be able to add a new feature, but I needed to be able to hold the general architecture in my head, and at the same time zoom in locally to the part I was working on. I found this really challenging and tbh I think it's probably one of those skills that takes years to hone. Fortunately for would-be tinkerers, the danger of breaking something can be mitigated somewhat if you or someone else has written good ...

### Tests

<img src="https://raw.githubusercontent.com/linbug/linbug.github.io/master/_downloads/dummies.jpg" style="height: auto;margin: 0 auto;"/>
<p class="captions">  Don't be a dummy. Write some tests. <a href="https://commons.wikimedia.org/wiki/File:Dummies.jpg">Source</a></p>
    
When I was working on personal software or data science projects, I knew I was *supposed* to write tests, but it was really more of an aspiration than a necessity. In a grown-up software environment, tests are a necessity if you want to have any kind of safety net. Whenever I wrote a new feature, I got into the habit of writing tests for it using Python's [unittest](https://docs.python.org/3/library/unittest.html) module. Sometimes writing the tests took longer than writing the code itself.

I also used [mocking](https://docs.python.org/3/library/unittest.mock.html) a bit, which lets you replace parts of your system that you want to test with mock objects. You might want to do this if the real objects are impractical to include in the test e.g. perhaps you want to test a method that calls another method to open an internet page. You don't want to actually open the page during the test, so you mock the sub-method and check that it got called at the right time. You could do this within a context manager (see below). 

*NB: You should avoid overzealous mocking. Ideally you should always be testing the behaviour of the original code pattern, rather than mocking your problems under the rug.*

### Model/View/Controller architecture
    
This is a broad programming concept that gets used a lot for designing user interfaces. The idea is that you have three discrete parts: the **Model**, which is the underlying data or information that you want to display; your **View**, which the display itself; and the **Controller**, which combines the model and the view. In the canonical Model/View/Controller (MVC) system, the Model and the View should never know that each other exist; it's all up to the controller to manage the two-way data flow between them. In practice, the boundaries can be more fuzzy.

This separation of concerns is supposed to be make your code more easily re-usable and testable: you can swap out the model for another and the view shouldn't care, and vice versa. I used MVC via Enthought's [TraitsUI](http://docs.enthought.com/traitsui/traitsui_user_manual/intro.html) package. MVC seems to be one of those contentious programming concepts that makes people very cross, as evidenced by the comments on [this article](https://blog.codinghorror.com/understanding-model-view-controller/) (warning to sensitive readers: the word 'hogwash' gets thrown around). 

### Interfaces and ABCs

Interfaces are another programming concept that you can be using in Python without even realising it. Fluent Python defines interfaces as:

>The subset of an object's public methods that enable it to play a specific role in the system. 

To look at it another way, an interface is the essential set of functions of attributes that make your object ... objecty. 

For example, in Python the only methods that a class needs to be considered a sequence are the `__len__` and `__getitem__` methods. A class that implements these methods *is* a sequence, regardless of what classes it inherits from, or whatever other methods it has. This set of methods comprise a sequence's interface. In this context where the interface is not formally declared, it is known as a **protocol**. You might be familiar with language such as 'file-like object' or 'callable' to describe Python protocols - objects that behave in a certain way in certain contexts. 

The process of operating with objects regardless of their types, as long as they implement certain protocols, is known in the programming community as *duck typing* (never mind if it *is* a duck -- does it quack like one?). This is a central concept in a dynamically-typed language such as Python, when type-checking is done at runtime.

<img src="https://raw.githubusercontent.com/linbug/linbug.github.io/master/_downloads/duck.jpg" style="height: 20em;margin: 0 auto;"/>
<p class="captions">This duck is late for the train.<a href="https://commons.wikimedia.org/wiki/File:White_domesticated_duck_stretching.jpg"> Source.</a></p>

There are also more formal ways of implementing interfaces in Python. These require you to explicitly define the interface and register any classes that implement it. When I was at Enthought I did this via the [Traits library](http://docs.enthought.com/traits/traits_user_manual/advanced.html), which has its own custom syntax for interfaces (scroll down to 'Implementing an Interface'). Core Python has an equivalent called ['Abstract Base Classes' (ABCs)](https://docs.python.org/3/library/abc.html), which are nicely introduced in Fluent Python chapter 11.

### Operator overloading

Following on from duck typing is operator overloading. This is a concept that just means that certain operators (such as + - =) can have different behaviours based on the type of arguments. So, if I define a custom class `Book` with an attribute `pages`, I can `+` two or more instances of `Book` by defining the methods `__radd__` and `__add__` on my class
(example from [here](http://blog.teamtreehouse.com/operator-overloading-python)).


{% highlight python %}
    class Book:
        def __init__(self, pages):
            self.pages = pages
            
        def __add__(self, other):
            return self.pages + other
            
        # this is Python's 'reverse add', meaning if it is unable
        # to add a + b, it will try b + a (i.e. we need to make the
        # addition commutative)
        def __radd__(self, other):
            return self.pages + other

{% endhighlight %}

Now we can happily use the `+` operator, and with the magic of operator overloading we need never check the type of what we're adding (it could be a number, a Book or a Duck, we don't care).

### Mixins

Finally for this post, mixins are classes that offer methods to other classes but are not themselves ever designed to be instantiated. Apparently this is a common design pattern in object-oriented languages. In Python mixins are used via multiple inheritence: a class that needs to use the mixin methods should inherit from the mixin class. However, the subclass should also inherit from another non-mixin class. This is not a formal rule, but if you follow it (and others in chapter 12 of Fluent Python!) you can bring order to the complexity of multiple inheritence.

Here's an example I wrote involving cute furries. Imagine you have the superclasses `Dog` and `Cat` that each have their own attributes that are specific to their species.

{% highlight python %}
  class Dog:
      def __init__(self, colour, bark):
          self.colour = colour
          self.bark = bark

  class Cat:
      def __init__(self, cuteness, name):
          self.cuteness = cuteness
          self.name = name
{% endhighlight %}

Now imagine that we want to make subclasses of `Dog` and `Cat` that have eating behaviour. We can create a mixin with eating methods: 

{% highlight python %}
  class Eat_Mixin:
      def eat(self, food):
          print('Yummy I like to eat {}'.format(food))

      def refuse(self, food):
          print('Yuck! I hate {}'.format(food))
{% endhighlight %}

Now we can use the mixin when creating the subclasses, using multiple inheritence (note `super` will only work without arguments like this in Python 3):

{% highlight python %}
  class Daschund(Dog, Eat_Mixin):
      def __init__(self, colour='black', bark='loud'):
          super().__init__(colour, bark)

  class Manx(Cat, Eat_Mixin):
      def __init__(self, cuteness=5, name='bubbins'):
          super().__init__(cuteness, name)
{% endhighlight %}

Now if we instantiate `Daschund` or `Manx`, they will inherit the same eat methods from `Eat_Mixin`. 
{% highlight bash %}
  >>> biggles = Daschund()
  >>> biggles.eat('cheese')
  Yummy I like to eat cheese

  >>> amanda = Manx()
  >>> amanda.refuse('chocolate')
  Yuck! I hate chocolate 
{% endhighlight %}

We shouldn't be inheriting from *just* `Eat_Mixin` because this was never designed to be used as a concrete class.


--------------------------------------------------------------------------------------------------------------------------------------


That's it for my first post in this series. Post 2 will look at some things about Python that I learned. 


