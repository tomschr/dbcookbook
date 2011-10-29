===================================
README for "The DocCookBook"
===================================

License
-------
This work is licensed as Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Germany License
(CC by-nc-sa 3.0 DE) See http://creativecommons.org/licenses/by-nc-sa/3.0/de/


Mission
-------
The DocCookBook project aims to create a collection of cookbook-style
solutions released under an open source license for the international 
DocBook community.

Concept
-------
This book is written in a "cookbook" style. The book contains "topics"
which are divided into a problem, the corresponding solution, some 
discussions, and optional related information.
It is very easy just to go to the table of contents and see if there
is something useful that fits to your problem.
Solutions are usually written in a procedural style which contains
several steps.


Target Group
------------
It is assumed you have a decent knowledge about XML and DocBook. It doesn't
hurt if you know CSS and XSLT.

As such, it is aimed more for DocBook developers than writers.


Adding New Topics
-----------------
A topic is this book which deals with a certain problem and gives a solution.
To make all the topic files consistent, there is an topic.empty.xml file which
should be used. Just copy it to one of the main directories (common, fo, html, 
structure) and give it a good name. Use the following command:

 $ hg copy en/xml/topic.empty.xml en/xml/DIR/TOPICNAME


