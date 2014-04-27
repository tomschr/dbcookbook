# -*- coding: UTF-8 -*-

import sys
import os, os.path

from .log import trace, logger
from .config import config

def cleanup(parser, args):
    """xsltproc --nonet --novalid -o ${HTMLOUTPUT} \
   ${BASEXSLT1}/misc/html2cleanhtml.xsl \
   ${HTMLINPUT}
    """
    pass

def singlehtml(parser, args):
    """saxon -o ${BUILDDIR}/tmp/DoCookBook.html  ${xmlin} \
     ${BASEXSLT1}/xhtml/docbook.xsl \
     generate.revhistory.link=0 generate.legalnotice.link=0 \
     ${ROOTID:+rootid=$ROOTID}
    """
    pass
    

def chunkedhtml(parser, args):
    """saxon -o ${BUILDDIR}/log.txt "${xmlin}" \
     ${BASEXSLT1}/xhtml/chunk.xsl \
     ${ROOTID:+rootid=$ROOTID}
    """
    pass


def html(parser, args):
    chunkedhtml(parser, args)
    singlehtml(parser, args)

# EOF