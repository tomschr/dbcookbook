#!/bin/sh

xsltproc --xinclude \
   --stringparam assembly.filename assembly.xml \
   --stringparam base.dir topics/ \
   --stringparam chunk.section.depth 2 \
   --stringparam manifest.in.base.dir 1 \
   ../../../../frameworks/db-xslt-ns/assembly/topic-maker-chunk.xsl \
   book.xml
