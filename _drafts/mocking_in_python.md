Several times recently I've found the need to use mocking when writing tests in Python. There's a couple of different ways to do this, and I haven't really got my head around them yet, so this post is to help me do so.

# Why mock?

Mocking is when you're replacing parts of your program which don't make sense to use for real in your tests. For example, imagine you have a function that you makes a call to a database, but when you unittest your function you don't want the added complexity of having the test actually accessing the database. This is where you can use mocking to fake the database return value. 

Another example that came up in my work recently was that I was testing a function that was accessing a value set by the user at runtime. Reproducing the whole chain of events that would lead to this value getting to this was really outside the scope of a unittest for this function (that we are getting into integration test territory). So instead I faked the return value of the user config option.

Mocking doesn't just let you fake return values, you can also do things like checking if an object has been called, how many times, and by what.

# How do you mock in Python?

There are a couple of different ways that you can mock in Python.
Mocking in python is covered by the `unittest.mock` library.

You can either mock with the `Mock` class, or `MagicMock`. `MagicMock` is a subclass of Mock, but it can best be thought of as an extension to `Mock` that supports the mocking of Python magic methods. 

Let's say you decided you want to connect to a database, query the row for a particular id and turn the returned value into a dictionary. You could use something like this:

{% highlight Python %}

import unittest
from unittest.mock import MagicMock

import psycopg2


class ConnectToDatabase():
    def query_database(self, id_num):
    	SQL = "SELECT * FROM test where test.id = (%s);"
    	conn = psycopg2.connect("dbname=test user=postgres")
    	cur = conn.cursor()
    	cur.execute(SQL, id_num)
    	result = cur.fetchone()
    	cur.close()
    	return result

    def parse_output(self, id_num):
    	query_output = self.query_database(id_num)
    	return dict(zip(['id', 'name', 'age'], query_output))

{% endhighlight %}

Now you might want to write a unittest to check that the `parse_output` function is working properly, but you don't actually want to connect to the database to do this. This is where you can use mocking:

{% highlight python %}

class TestConnectToDatabase(unittest.TestCase):
 	def test_that_expected(self):
 		db = ConnectToDatabase()
 		db.query_database = MagicMock(return_value=(20, 'Mr Blobby', 64))
 		self.assertEqual(
 			db.parse_output(20), {'id': 20, 'name': 'Mr Blobby', 'age': 64})

{% endhighlight %}

1. mocking an instance of a class and an instance method
using Mock() or MagicMock() 
MagicMock is a subclass of Mock; the difference is that it already has implementations of most of the magic (e.g. `__hash__`)


2. replacing the entire class with a mock instance
 using patch












# Mocking caveats
