Things I learned during my internship at Enthought
I am so behind with my blog that I haven't even gotten round to talking about [Enthought](https://www.enthought.com/) yet, where I interned from September last year until a couple of weeks ago. Enthought write scientific software as well as provide consultancy and training services. They do almost everything in Python, and there are some very skilled Pythonistas working there. I actually originally learned Python using [Enthought's training videos and exercises](https://training.enthought.com/), so it was very cool to get to work there. For my internship I worked on adding a new feature to the [Canopy Geoscience]() application, a piece of software that lets geoscience researchers analyse their data. 

Rather than talk about the project in this post I thought I'd jumble together some things I learned, mostly as a memory aid to myself. I tried to keep a list of new concepts/tools as I came across them.

image of the notebook I used

# Stuff I learned

## Programming concepts

1. Navigating a huge codebase
The hardest thing I found about my project was learning how to work with a big codebase. I imagined the codebase like a big and complex mechanism, with lots of interconnecting cogs, cams and pulleys. Being able to add a new feature to the code didn't mean I had to be intimately *au fait* with each part, but I needed to be able to hold the general architecture in my head, and at the same time zoom in locally to the part I was working on. I found this really challenging and it took a few weeks to get used to it. Fortunately, the danger of breaking something can be mitigated somewhat if you have written good ...

2. Tests
When I was working on personal software or data science projects, I knew I was *supposed* to write tests, but it was really more of an aspiration than a necessity. In a grown-up software environment, tests are a necessity if you want to have any kind of safety net. Whenever I wrote a new feature, I got into the habit of writing tests for it using Python's [unittest](https://docs.python.org/3/library/unittest.html) module.

I also used [mocking]() a bit 
- unittest
- mocking


2. Model/View/Controller architecture

4. Abstract Base Classes (ABCs) and Interfaces

Mixins
Mixins are classes that offer methods to other classes but are not themselves ever designed to be instantiated. Apparently this is a common design pattern in javasript. In Python mixins are used via multiple inheritence  

3. Singletons
- 

Closures

Operator overloading
A concept that just means that certain operators (such as + - =) can have different behaviours based on the type of arguments.


## Python specifics

1. Method resolution order (__mro__) and super
    Python supports multiple inheritence, meaning that a class can inherit from more than one base class. If both base classes support the same method, what is the order of priority for inheritence? Things can get pretty knarly as Python's inheritence rules are subtle and differ between Python 2 and 3. Method resolution order refers to the order in which a method is called from a class's superclasses inherit from superclasses . Calling super on a Python class might be expected to return the class that it 


2. grin
    A Python package written by Robert Kern (who happens to be an Enthought employee) which was a lifesaver for navigating the codebase. It's basically a nicer version of grep, for Python-specific files.

3. context managers
- with
- contextlib

4. logging

5. Package imports

6. eval() and exec()
Like global, eval and exec are generally considered to be dirty by Python users - if you're using them there's probably something wrong with your code (a code smell). However, they exist becuase there are valid use cases for them.

7. Weak sets
Related to singletons, weak sets will magically disappear if no . They are also a bit smelly

8. flake8
Nannyish but necessary

### Git tricks

1. git checkout -p
I love the -p command! It lets you select hunks of your code so that, in this case, you don't have to checkout the whole commit but you can select parts that you want to checkout. I used this when I wanted to discard some changes in
the -p command also works for git add, which is really useful when you've made a lot of changes at once but you want to  fed 
 
2. Retrospectively adding a file you forgot to the add to the last commit
git add file/you/forgot
git commit --amend --no-edit

3. Interactive rebase

4. git update-index --again

5. git bisect



