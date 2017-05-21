#!/bin/sh

xsltproc -o book-assembled.xml \
   ../../../../frameworks/db-xslt-ns/assembly/assemble.xsl \
   topics/assembly.xml
