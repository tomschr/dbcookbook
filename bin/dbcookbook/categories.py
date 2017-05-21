# -*- coding: UTF-8 -*-

import sys
import os, os.path

from .log import trace, logger
from .config import config

from lxml import etree


@trace(logger)
def resolvexinclude(parser, args=None):
    """Resolves XIncludes in main XML file and save the result into tempdir
    """
    logger.debug("Using {args.mainfile}".format(**locals()))
    tempdir=config.get('Common', 'tempdir')
    
    if not os.path.exists(tempdir):
        os.makedirs(tempdir)
        
    xmlfile = os.path.basename(args.mainfile)+".tmp"
    xmlparser = etree.XMLParser(
        # dtd_validation=False,  # use default (False)
        ns_clean=True)
    tree = etree.parse(args.mainfile, xmlparser)
    tree.xinclude()
    tree.write( os.path.join(tempdir, xmlfile), 
                encoding="utf-8",
                standalone=True,
              )
    return parser, args

@trace(logger)
def resolvecategories(parser, args=None):
    basefile=os.path.basename(args.mainfile)
    tempdir=config.get('Common', 'tempdir')
    xmltmpfile = os.path.join(tempdir, basefile+".tmp")
    xmlfile = os.path.join(tempdir, basefile)
    
    # We resolve any XIncludes and store it in the tempdir
    resolvexinclude(parser, args)
    
    if not args or args.no_category:
        # Should we use copy instead of rename?
        os.rename(xmltmpfile, xmlfile)
        logger.debug("No categories created; make {xmltmpfile} -> {xmlfile}".format(**locals()))
        return parser, args

    categoryxsl=config.get('XSLT1', 'categoryxsl')
    xmldoc = etree.parse(xmltmpfile)
    transform = etree.XSLT(etree.parse(categoryxsl))
    
    logger.debug("Transforming {xmltmpfile} with {categoryxsl}".format(**locals()))
    resulttree = transform(xmldoc)
    
    logger.debug("-- Return from XSLT processor (Start) --")
    for entry in transform.error_log:
        logger.debug("{entry.message}".format(**locals()))
    logger.debug("-- Return from XSLT processor (End) --")
    
    logger.debug("Writing transformation result to {xmlfile}".format(**locals()))
    resulttree.write(xmlfile, encoding="utf-8", standalone=True,)
    
# EOF