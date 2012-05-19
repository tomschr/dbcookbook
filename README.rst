===================================
Welcome to "The DoCookBook"
===================================

License
-------
This work is licensed as Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Germany License
(CC by-nc-sa 3.0 DE) See http://creativecommons.org/licenses/by-nc-sa/3.0/de/


Mission
-------
The DoCookBook project aims to create an open source book about DocBook and the DocBook XSL 
stylesheets written in a cookbook-style manner and released under a Creative Commons license.


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


Contribute
----------
Do you miss anything? Have you discovered an error? Have an idea about how
to improve the book? Great! If you want to contribute to the book, you can
do it in different ways:

* Write me a mail to <tom_schr (AT) web.de> and send me your comments
* Extend the tickets (Ideas for New Topics) at http://sf.net/p/doccookbook/tickets/
* Clone my repository on Sourcforge and send me patches

Here is a procedure about how to clone the repository:

1. Download Mercurial from http://mercurial.selenic.com and install it on your system.

2. Clone my Sourceforge repository with the Mercurial command hg:
::
  $ hg clone http://hg.code.sf.net/p/doccookbook/code doccookbook-code

3. If you want to create a new topic, decide in which chapter it could belong (markup, common customizations, structure, fo, html, or any other). For example, if you want an addition to DocBook´s structure chapter, use the existing template and copy it (where 'FOO' is an abstract term; replace it with something meaningful):
::
  $ hg copy en/xml/topic.empty.xml en/xml/structure/topic.FOO.xml

4. Open the XML file which contains a chapter element. In our example, it would be en/xml/dbc-structure.xml. Scroll to the <xi:include> elements and insert the following code:
::
  <xi:include href="structure/topic.foo.xml"/>

5. Open the XML file en/xml/structure/topic.foo.xml and write your topic.

6. When you are finished, create a diff:
::
  $ hg diff > foo.patch

7. Send the diff to me.


Find more information about Mercurial at http://mercurial.selenic.com/.


How you can help
----------------

* Find typos, grammar problems, inconsistencies, or plain errors
* Send me patches
* Write your owm topic


