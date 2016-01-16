---
layout: post
title: Slaying the SQL dragon
categories: [SQL, databases]
tags: []

---

I think many developers have tools or techniques that they're scared of using. Some magic that doesn't make sense, so they avoid using it in the hopes it will go away. Maybe for some people it is multiple inheritence, for others functional programming. For me, it's databases. I'm not really sure where my fear of databases came from. Maybe it's because you have to use a special alien language to speak to them. Maybe it's because they can be large and unwieldy and difficult to look at all at once. I don't really know. All I know is, it's time to slay this dragon. Or rather, not slay it, but learn how to speak to it nicely so that it will give me gold :D. What follows below is my brief introduction to <s>dragons</s> relational databases.

<img src="https://upload.wikimedia.org/wikipedia/commons/5/57/19360-black-chinese-dragon-1920x1080-artistic-wallpaper.jpg" title= "here be SQL" style="margin: 0 auto;"/>

##What is a relational database?
A [relational database](https://en.wikipedia.org/wiki/Relational_database) is a digital database organised according to the [relational model](https://en.wikipedia.org/wiki/Relational_model) of data: a simple set of concepts that allows us to build very complex data structures. In essence, relational databases contain one or more tables with rows and columns, where each row has a unique key for identification. Rows in one table can be linked to rows in another table by storing the value of the row key to be linked to. A useful analogy I saw [here](http://sql.learncodethehardway.org/book/introduction.html) is that a database is analogous to a whole Excel spreadsheet file, whereas the individual database tables are like the tabs/worksheets in that Excel file.

Different relationships can link columns within and between tables in a relational database. You can have [one-to-one](http://www.databaseprimer.com/pages/relationship_1to1/) relationships, [one-to-many](http://www.databaseprimer.com/pages/relationship_1tox/) relationships and [many-to-many](http://www.databaseprimer.com/pages/relationship_xtox/) relationships between rows in different tables.

##Advantages of relational databases
Why not just use one big flat table? Why bother with linking between different tables? There are several advantages to relational databases compared to a standard flat file:

1. Data is only stored once

    You don’t need to have multiple records for a single entity. Let’s say for example you have a database of ten friends in your address book, and these ten friends collectively live in four different cities. You can have two tables in your database, one for friend names and street address, and one for cities. You can create links between rows in your cities and friends tables without the need to duplicate any information. This is good for several reasons:

    - Less duplication means the database takes up less space and so is more storage efficient.

    - Since there’s no duplication, you also eliminate possible inconsistencies, for example if you had a column in a single flat table for city, you might end up with some items misspelled (e.g. ‘Londn’ instead of ‘London’).

    - It should also be much easier to change information if it only exists in one place, e.g. if for some bizarre reason the UK decided to change the name of London to ’Jabberwocky’, you’d only have to update this information once in our fictitious relational database of addresses.

2. Data has a fixed type

    This means that your text will always be interpreted as text, your numbers as numbers, your dates as dates. You can avoid typos like *iO* instead of 10.

3. You can apply complex queries

    ...to pull out exactly the information you want, from multiple tables at once. You can use these queries for further analysis without having to duplicate your data, as you might do in an Excel spreadsheet, thus cutting out the middle man.

4. It’s easier to maintain security

    By splitting the data up into separate tables, you can ensure that in certain situations, only part of the data can be made accessible to a particular individual. For example, if you are using a database for a web application, you might want to restrict an individual user to their own information, instead of giving them access to all of the email addresses of everyone signed up to your service.

5. You can cater to future requirements

    It’s easy to add more data that are not yet needed, but might be in the future. For example, you might be going to a cheese rolling convention in Manhattan, where you anticipate making lots of new friends from around the world. In preparation for your trip, you could expand your cities table in you friend address database to include all of the cities in the world, even though they aren't being referenced by anything yet. You can’t do this with a flat table (well, you could, but not without adding a lot of ugly null values). Of course, designing a database from scratch that is extensible and maintainable can be really tricky, as demonstrated in this fun blog post about [designing the most egalitarian marriage database](http://qntm.org/gay).

##Interacting with relational databases
Data manipulation in relational databases is performed by making queries in Structured Query Language (SQL). All SQL operations do one of four fundamental types of operation:

   **Create** -- Putting data into the table

   **Read** -- Querying data from the table

   **Update** -- Changing data that is already in the table

   **Delete** -- Removing data from the table

These all add up to the delightful acronym 'CRUD'.

Wikipedia says that SQL is based on [relational algebra](https://en.wikipedia.org/wiki/Relational_algebra) and [tuple relational calculus](https://en.wikipedia.org/wiki/Tuple_relational_calculus). I don't know what those are, but what I should take from that is that SQL's roots are in mathematics. It is not a programming language. Thus, you're not allowed to get annoyed if SQL isn't like you're favourite programming language. It's a fundamentally different thing.

Learning SQL syntax is a whole massive topic in itself. I found the following resources to be helpful:

- [Learn SQL the Hard Way](http://sql.learncodethehardway.org/book/)
- [SQL zoo](http://sqlzoo.net/w/index.php?title=SQL_Tutorial&redirect=no)

##Database Management Systems (DBMSs)
To complicate things further, there are lots of different kinds of systems for letting a user and other applications communicate with a database. Popular DBMSs include PostgreSQL, MySQL, Microsoft SQL Server, Oracle and SQLite. They all have slightly different advantages and disadvantages. Of these, SQLite is the major odd one out as it doesn't have a client-server architecture (the database lives on a computer server, and is accessed from a separate machine, which is the client); SQLite is actually embedded in the end program itself. This makes it a good DBMS to start playing around with, as you don't need to fiddle around with servers.

##What about NoSQL??
Sigh. Just when you thought you were getting the hang of things, you find out there is another kind of database called NoSQL. NoSQL is a kind of non-relational database with a completely different kind of architecture. NoSQL is supposed to be more scalable and fixes problems with the relational model. People on the internet seem to treating it like it is the hot new thing. I don't even want to think about this right now; I'll mentally bookmark it for later.

---------------------------------------------------------------------------------------------------------------

Thus ends my very short introduction to relational databases. I'm currently learning to speak SQL by working on a project to build an API for some [NASA rainfall data](http://neo.sci.gsfc.nasa.gov/view.php?datasetId=TRMM_3B43D&date=2015-09-01). This involves working with GIS data, which is another level of complexity. I'll write up this project in another post.



