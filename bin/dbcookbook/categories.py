# -*- coding: UTF-8 -*-

import sys
import os, os.path

from .log import trace, logger
from .config import config

@trace(logger)
def resolvexinclude(parser, args=None):
    """Resolves XIncludes in main XML file and save the result into tempdir
    """
    
    from lxml import etree
    
    if not args or args.no_category:
        return
    
    logger.debug("Using {args.mainfile}".format(**locals()))
    tempdir=config.get('Common', 'tempdir')
    
    if not os.path.exists(tempdir):
        os.makedirs(tempdir)
        
    xmlfile = os.path.basename(args.mainfile)
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
    
def resolvecategories(parser, args=None):
    resolvexinclude(parser, args)

# EOF