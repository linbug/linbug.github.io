---
layout: post
title: Coursera's machine learning course (implemented in Python)
category: data science tools
---

![Boston has some nice libraries]({{ site.url }}/_downloads/library.jpg)

[Last week]({% post_url 2015-06-28-Getting-started %}) I started [Stanford's machine learning course](https://www.coursera.org/learn/machine-learning) (on Coursera). The course consists of video lectures, and programming exercises 
to complete in Octave or MatLab. Contrary to what Ng says, the most popular languages for data science seem to be Python, R or Julia (high level languages), and Java, C++ or Scala/Clojure (low level languages). Ryan Orban of Zipfian Academy recommends you 
[learn one of both](https://www.youtube.com/watch?v=c52IOlnPw08#t=8m35s). I've never heard of people using MatLab outside of an academic context, so I've decided to attempt the exercises in Python.

---------------------------------------------------------
###Week two programming assignment: linear regression
The first assignment starts in week two and involves implementing the gradient descent algorithm on a dataset of house prices. At a theoretical level, [gradient descent](https://en.wikipedia.org/wiki/Gradient_descent) is an algorithm that is used to find the minimum of a function. That is, 
given a function that is defined by a set of parameters, gradient descent iteratively changes the parameter values, so that the function is progressively minimised. This 'tuning' algorithm is used for lots of different machine learning applications. In this exercise, we were shown how to use gradient descent to find the best fit for a linear regression.  

**I realise what I just said will sound like 
gobbledigook if you haven't used gradient descent before! I hope this post will explain things better**.
 
####The scenario: [food trucks](http://www.imdb.com/title/tt2883512/)

We were told to imagine that we are a CEO of a large food truck franchise and we are considering cities to send more food trucks (if I had a food truck franchise, my food trucks would serve [pierogei](https://en.wikipedia.org/wiki/Pierogi_)).
Obviously, we want to find a way to maximise our profit. Fortunately we already have food trucks dishing out hot dumplings in several cities, 
so we can examine the data from these and predict the profits of future trucks. 
Since we have this training dataset, this is a [supervised learning](https://en.wikipedia.org/wiki/Supervised_learning) rather than an [unsupervised learning](https://en.wikipedia.org/wiki/Unsupervised_learning) task. 
Our dataset includes the population sizes of the cities where we already have food trucks, and our profits from each of these cities. Since we only have one input variable (population size) per output variable that we're trying to predict (profits), this is univariate (as opposed to multivariate) linear regression. 
Here's what the data looks like on a scatter plot

![scatter graph]({{ site.url }}/_downloads/scatter1.png)

As you can see, profits increase with increasing city size. But how can we predict how much profit future food trucks will make? We'll have to fit a regression line summarises our past data.

####The hypothesis function
The standard equation for a line (with just one variable, x) is:
$$y = mx + c$$
We'll use machine learning to help us to find values for m and c (that is, the values for the gradient and y-intercept of the line) that best describe the data. From now on, I'll refer to c as $\theta_0$ and m as $\theta_1$ (this notation makes things easier when we start dealing with more than one variable).
Our machine learning algorithm will come up with values for $\theta_0$ and $\theta_1$ that we'll be able to use to plug into the linear equation, above, and so predict values of y (i.e. profit) for any values of x (i.e. population size) we so desire. 
In machine learning lingo, these outputs are called **hypotheses**. For linear regression with one variable, our hypothesis function will be of the form:
$$h_\theta(x) = \theta_0 + \theta_1x_1$$
Which you can see is just a different representation of the equation above.

####The cost function
How can we assess how good a particular hypothesis is? For this we need something called a [**cost function**](https://en.wikipedia.org/wiki/Loss_function) (otherwise known as a loss function), which quantifies how much our prediction $h_\theta(x)$ 
deviates from the actual value of $y$. So we want to find the values for $\theta_0$ and $\theta_1$ that will make the output from our cost function as small as possible. 

The cost function that we used here was the [mean squared error](https://en.wikipedia.org/wiki/Mean_squared_error):
$$J(\theta_0,\theta_1) = \frac 1{2m}\sum_{i=1}^m(h_\theta(x^{(i)})-y^{(i)})^2$$

Let's break this down. We can see that the cost function, $J$, takes the values of $\theta_0$ and $\theta_1$ as inputs. The term $h_\theta(x^{(i)})-y^{(i)}$ is finding the difference between the hypothesis value
 (estimated profit, under the proposed values of $\theta_0$ and $\theta_1$) and the actual value of y (actual profit) for each of the examples in our training dataset (identified by the superscript $i$). This is our error value; the bigger the difference 
 between the estimated and actual values, the larger the error. 
 
 We then square each of the error values (this makes them all positive) and add them together. Then we find the average of these values by dividing by $\frac 1m$. We also multiply by $\frac12$, as this makes computation
of the gradient descent (coming up next!) more convenient. 

 So, altogether the cost function computes half of the average of the sum of squared errors. Phew!
 
 In Python, here's how I programmed the cost function:
 
 {% highlight python %}

 # define a function that computes the cost function J()
 def costJ(X,y,theta):
    '''where X is a pandas dataframe of input features, plus a column of ones to accommodate theta 0; 
    y is a vector that we are trying to predict using these features, and theta is an array of the parameters'''
    
    m = len(y)
    hypothesis = X.dot(theta) # if you're using a np array, you need to use flatten to remove nesting
    a = (hypothesis[0]-y)**2 # otherwise this will give you completely the wrong answerX[:, 0]
    J = (1/(2*m)*sum(a))
    return J

{% endhighlight %}
 
 ####Gradient descent
 How can we efficiently find values of $\theta_0$ and $\theta_1$ that minimise the cost function, you cry? Here's where gradient descent comes in. The gradient descent algorithm updates the values for $\theta_0$ and $\theta_1$
 in the direction that minimises $J(\theta_0, \theta_1):

$$\theta_j := \theta_j - \alpha\frac{\partial}{\partial\theta_j} J(\theta_0,\theta_1)$$
 
 The direction we should move to minimise the cost function is found by taking the derivative (the line tangent to) the cost function; this is what the term $\frac{\partial}{\partial\theta_j} J(\theta_0,\theta_1)$ is doing.
 We then multiply this by the coefficient $\alpha$ to work out how far we should move along this tangent. Update for both values of $\theta_0$ and $\theta_1$ before re-computing the cost function. Rinse and repeat until 
 the output of the cost function reaches a steady plateau. The step sizes we take at each iteration towards the minimum is determined by $\alpha$. 
 
 When applied specifically to linear regression, the gradient descent algorithm can be derived like this:
 
 $$
 \begin{align}
 &\theta_0 := \theta_0 - \alpha\frac1m\sum_{i=1}^m(h_\theta(x^{(i)})-y^{(i)})\\
 \\
  &\theta_1 := \theta_1 - \alpha\frac1m\sum_{i=1}^m(h_\theta(x^{(i)})-y^{(i)})x^{(i)}\\
  \end{align}
  $$
  
  where $\theta_0$ and $\theta_1$ are updated simultaneously until convergence. (If it seems like I just skipped over that derivation, it's because it's [really long](http://math.stackexchange.com/questions/70728/partial-derivative-in-gradient-descent-for-two-variables/189792#189792)
  and I don't quite understand it yet.)
  
  Here's how my gradient descent algorithm looks in Python:
  # define a function that will implement the gradient descent algorithm
def gradDesc(X,y,theta,alpha,num_iters):
    '''Implement the gradient descent algorithm, where alpha is the learning rate and num_iters is the number of iterations to run'''
    
    Jhistory = [] #initiate an empty list to store values of cost function after each cycle
    theta_update = theta.copy()   
    
 {% highlight python %}   
    for num_iter in range(num_iters):
        #these update only once for each iteration
        hypothesis = X.dot(theta_update)
        loss = hypothesis[0]-y 
        
        for i in range(len(X.columns)):
            #these will update once for every parameter
            theta_update[i] = theta_update[i] - (alpha*(1.0/m))*((loss*(X.iloc[:,i])).sum())

        Jhistory.append(costJ(X,y,theta_update))
        
    return Jhistory, theta_update
{% endhighlight %}

So, after all of that we end up with parameters of $\theta_0$ and $\theta_1$ that we can use to plot on our scatter graph.
![scatter graph with gradient descent line]({{ site.url }}/_downloads/scatter2.png)

Woo! Gradient descent was able to find values of $theta_0$ and $theta_1$ to fit a nice regression line to our data. Now we can predict that if we send food trucks to Cambridge, UK (population ~128,500 during term time),
we'll make ~$113574, whereas if we open up shop in Cambridge, MA (population ~107,300), we can expect to make ~$88847.
---------------------------------------------------------
I hope that this was a useful introduction to gradient descent. You can see my code [here](http://nbviewer.ipython.org/github/linbug/Coursera-s-machine-learning-course/blob/master/ml%20ex1.ipynb) We can also use gradient descent for multivariate linear regression
(I won't go into this here, maybe in another post). I expect we'll be using variations of this algorithm for other applications later in the course, since it seems to be a machine learning staple.
