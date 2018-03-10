#!/usr/bin/python3
# -*- coding: UTF-8 -*-

import sys
import os

from dbcookbook.config import config,  __version__
from dbcookbook import internaltest
from dbcookbook.cli import parsecommandline
from dbcookbook.log import logger, trace, createlogger
from dbcookbook.env import initenv
from dbcookbook.formats import html
from dbcookbook.categories import resolvecategories
from dbcookbook.zip import createzip

_abspath=os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))+"/"


def main():
    parserobj=parsecommandline()
    args=parserobj[1]
    createlogger(args.verbose)
    
    logger.debug("CLI arguments: {args}".format(args=args))
    logger.debug("Found these sections in INI: {sects}".format(sects=config.sections()))

    # Set the absolute path, so we always resolve correctly:
    config.set('Common', 'abspath', _abspath)

    logger.debug("""Environment:
    absolute path={path}
    xhtmldir={xhtmldir}
    fodir={fodir}
    """.format(path=_abspath, **dict(config["XSLT1"].items()) ))
    
    initenv(*parserobj)
    resolvecategories(*parserobj)
    html(*parserobj)
    createzip(*parserobj)
    
    return parserobj


def __test():
    import doctest
    doctest.testmod()

    
if __name__=="__main__":
    from configparser import InterpolationMissingOptionError
    from lxml.etree import XSLTApplyError
    line="-"*10
    
    try:
        logger.debug("{line} START {line}".format(**locals()))
        obj = main()
        
    except (InterpolationMissingOptionError, 
            NameError, 
            XSLTApplyError, 
            FileNotFoundError
           ) as error:
        logger.critical("{classname}: {error}".format(classname=error.__class__.__name__, error=error))
        sys.exit(10)
    
    if obj[1].test:
        internaltest()
    
    logger.info("Success!")
    logger.debug("{line} END {line}".format(**locals()))

# EOF