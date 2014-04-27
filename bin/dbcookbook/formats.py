# -*- coding: UTF-8 -*-

import sys
import os, os.path

from .log import trace, logger
from .config import config

from lxml import etree

def cleanup(parser, args):
    """xsltproc --nonet --novalid -o ${HTMLOUTPUT} \
   ${BASEXSLT1}/misc/html2cleanhtml.xsl \
   ${HTMLINPUT}
    """
    pass

def singlehtml(parser, args):
    """Tranform XML input and generate single HTML page
    """
    basefile=os.path.basename(args.mainfile)
    tempdir=config.get('Common', 'tempdir')
    xmlfile = os.path.join(tempdir, basefile)
    xhtmlsingle = config.get('XSLT1', 'xhtmlsingle')
    
    if not os.path.exists(xmlfile):
        raise FileNotFoundError("File {xmlfile} not found".format(**locals()))

    xmlparser = etree.XMLParser(
        # dtd_validation=False,  # use default (False)
        ns_clean=True)
    xmldoc = etree.parse(xmlfile, xmlparser)
    transform = etree.XSLT(etree.parse(xhtmlsingle))
    
    logger.debug("Transforming {xmlfile} with {xhtmlsingle}".format(**locals()))
    params = {
             #'base.dir':       etree.XSLT.strparam(tempdir),
             'use.extensions': etree.XSLT.strparam('0'),
             }
             
    if args.rootid:
         params.update(rootid=args.rootid)
    
    resulttree = transform(xmldoc, **params)
    
    logger.debug("-- Return from XSLT processor (Start) --")
    for entry in transform.error_log:
        logger.debug("{entry.message}".format(**locals()))
    logger.debug("-- Return from XSLT processor (End) --")
    
       
@trace(logger)
def chunkedhtml(parser, args):
    """Tranform XML input and generate chunked HTML pages
    """
    basefile=os.path.basename(args.mainfile)
    tempdir=config.get('Common', 'tempdir')
    xmlfile = os.path.join(tempdir, basefile)
    xhtmlchunk = config.get('XSLT1', 'xhtmlchunk')
    
    if not os.path.exists(xmlfile):
        raise FileNotFoundError("File {xmlfile} not found".format(**locals()))
    
    xmlparser = etree.XMLParser(
        # dtd_validation=False,  # use default (False)
        ns_clean=True)
    xmldoc = etree.parse(xmlfile, xmlparser)
    transform = etree.XSLT(etree.parse(xhtmlchunk))
    
    logger.debug("Transforming {xmlfile} with {xhtmlchunk}".format(**locals()))
    params = {
             'base.dir':       etree.XSLT.strparam(tempdir),
             'use.extensions': etree.XSLT.strparam('0'),
             }
    
    if args.rootid:
         params.update(rootid=args.rootid)
        
    resulttree = transform(xmldoc, **params)
    
    logger.debug("-- Return from XSLT processor (Start) --")
    for entry in transform.error_log:
        logger.debug("{entry.message}".format(**locals()))
    logger.debug("-- Return from XSLT processor (End) --")
    
    

def html(parser, args):

    chunkedhtml(parser, args)
    singlehtml(parser, args)
    cleanup(parser, args)

# EOF