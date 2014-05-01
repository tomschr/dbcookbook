# -*- coding: UTF-8 -*-

import sys
import os, os.path

from .log import trace, logger
from .config import config

from lxml import etree


@trace(logger)
def cleanup(parser, args):
    """xsltproc --nonet --novalid -o ${HTMLOUTPUT} \
   ${BASEXSLT1}/misc/html2cleanhtml.xsl \
   ${HTMLINPUT}
    """
    tempdir=os.path.normpath(config.get('Common', 'tempdir'))
    htmldir=os.path.normpath(config.get('Common', 'htmldir'))
    
    # Consistency check
    for d in (tempdir, htmldir):
        logger.info("Checking for {}".format(d))
        if not os.path.exists(d):
            raise FileNotFoundError("Expected directory {} not found".format(d))
    
    cleanhtml=config.get('XSLT1', 'cleanhtml')
    if args.rootid:
        htmlfiles = [ "{args.rootid}.html".format(**locals()) ]
        logger.info("Using rootid={args.rootid} with file {htmlfiles[0]}".format(**locals()))
    else:
        import glob
        pwd=os.getcwd()
        os.chdir(tempdir)
        htmlfiles = iter(glob.glob("*.html".format(**locals())))
        os.chdir(pwd)
        
    
    xmlparser = etree.XMLParser(
        dtd_validation=False,  # use default (False)
        no_network=False,
        ns_clean=True,
        )
    
    transform = etree.XSLT(etree.parse(cleanhtml))
    for entry in htmlfiles:
        logger.info("Cleaning up '{entry}'...".format(**locals()))
        resultfile=os.path.join(htmldir, entry)
        params={}
        xmldoc = etree.parse( os.path.join(tempdir, entry), xmlparser)
        resulttree = transform(xmldoc, **params)
        
        #logger.debug("-- Return from XSLT processor (Start) --")
        for e in transform.error_log:
            logger.debug("{e.message}".format(**locals()))
        #logger.debug("-- Return from XSLT processor (End) --")
        
        logger.debug("Writing result from cleanup to '{resultfile}'".format(**locals()))
        resulttree.write( resultfile, 
                          method="xml",
                          encoding="UTF-8",
                          standalone=True,
                         )

@trace(logger)
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
    
    logger.info("*** Transforming {xmlfile} with {xhtmlsingle}".format(**locals()))
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
    
    logger.info("*** Transforming {xmlfile} with {xhtmlchunk}".format(**locals()))
    params = {
             'base.dir':       etree.XSLT.strparam(tempdir),
             'use.extensions': etree.XSLT.strparam('0'),
             }
    
    if args.rootid:
         params.update(rootid=args.rootid)
        
    resulttree = transform(xmldoc, **params)
    
    logger.debug("-- Return from XSLT processor (Start) --")
    for entry in transform.error_log:
        logger.info("{entry.message}".format(**locals()))
    logger.debug("-- Return from XSLT processor (End) --")
    
    

def html(parser, args):
    """Generate HTML files"""
    chunkedhtml(parser, args)
    singlehtml(parser, args)
    cleanup(parser, args)

# EOF