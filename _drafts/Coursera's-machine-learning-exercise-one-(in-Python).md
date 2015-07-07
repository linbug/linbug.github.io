---
layout: post
title: Coursera's machine learning course (implemented in Python)
category: data science tools
---

[Last week ]({% post_url 2015-06-28-Getting-started %} I started [Stanford's machine learning course](https://www.coursera.org/learn/machine-learning) (on Coursera). The course consists of video lectures, and programming exercises 
to complete in Octave or MatLab. Contrary to what Ng says, the most popular languages for data science seem to be Python, R or Julia (high level languages), and Java, C++ or Scala/Clojure (low level languages). Ryan Orban of Zipfian Academy recommends you 
[learn one of both](https://www.youtube.com/watch?v=c52IOlnPw08#t=8m35s). I've never heard of people using MatLab outside of an academic context, so I've decided to attempt the exercises in Python.

###Week two programming assignment: linear regression
The first assignment starts in week two and involves implementing the gradient descent algorithm on a dataset of house prices. At a theoretical level, [gradient descent](https://en.wikipedia.org/wiki/Gradient_descent) is an algorithm that is used to find the minimum of a function. That is, 
given a function that is defined by a set of parameters, gradient descent iteratively changes the parameter values, so that the function is progressively minimised. This 'tuning' algorithm is used for lots of different machine learning applications. In this exercise, we were shown how to use gradient descent to find the best fit for a linear regression.  

**I realise what I just said will sound like 
gobbledigook if you haven't used gradient descent before! I hope this post will explain things better**.
 
####The scenario: [food trucks](http://www.imdb.com/title/tt2883512/)

We were told to imagine that we are a CEO of a large food truck franchise and we are considering cities to send more food trucks (if I had a food truck franchise, my food truck would serve [pierogei](https://en.wikipedia.org/wiki/Pierogi_)).
Obviously, we want to find a way to maximise our profit. Fortunately we already have food trucks dishing out hot dumplings in several cities, 
so we can examine the data from these and predict the profits of future trucks. 
Since we have this training dataset, this is a [supervised learning](https://en.wikipedia.org/wiki/Supervised_learning) rather than an [unsupervised learning](https://en.wikipedia.org/wiki/Unsupervised_learning) task. 
Our dataset includes the population sizes of the cities where we already have food trucks, and our profits from each of these cities. Since we only have one input variable (population size) per output variable that we're trying to predict (profits), this is univariate (as opposed to multivariate) linear regression. 
Here's what the data looks like on a scatter plot:

As you can see, profits increase with increasing city size. But how can we predict how much profit future food trucks will make? We'll have to fit a regression line summarises our past data.

####The hypothesis function
The standard equation for a line (with just one variable, x) is:
$$y = mx + c$$
We'll use machine learning to help us to find values for m and c (that is, the values for the gradient and y-intercept of the line) that best describe the data. From now on, I'll refer to c as $\theta_0$ and m as $\theta_1$ (this notation makes things easier when we start dealing with more than one variable).
Our machine learning algorithm will come up with values for $\theta_0$ and $\theta_1$ that we'll be able to use to plug into the linear equation, above, and so predict values of y (i.e. profit) for any values of x (i.e. population size) we so desire. 
In machine learning lingo, these outputs are called **hypotheses**. For linear regression with one variable, our hypothesis function will be of the form:
$$h_/theta(x) = \theta_0 + \theta_1x_1$$
Which you can see is just a different representation of the equation above.

####The cost function
How can we assess how good a particular hypothesis is? For this we need something called a [**cost function**](https://en.wikipedia.org/wiki/Loss_function) (otherwise known as a loss function), which quantifies how much our prediction $h_/theta(x)$ 
deviates from the actual value of $y$. So we want to find the values for $\theta_0$ and $\theta_1$ that will make the output from our cost function as small as possible. 

The cost function that we used here was the [mean squared error](https://en.wikipedia.org/wiki/Mean_squared_error) of the 

First, we come up with a way of measuring how good our fit line is. This is the cost function, otherwise known as the squared error function:

Here we see that the values of $\theta_0$ and $\theta_1$ become the inputs for our cost function. 

[supervised learning algorithm](on a toy dataset of house prices