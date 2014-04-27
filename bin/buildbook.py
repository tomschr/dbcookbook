#!/usr/bin/python3
# -*- coding: UTF-8 -*-

import sys
import os

from dbcookbook.config import config,  __version__
from dbcookbook import internaltest
from dbcookbook.cli import parsecommandline
from dbcookbook.log import logger, trace, createlogger
from dbcookbook.env import initenv


_abspath=os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))+"/"


def main():
    parser, args=parsecommandline()
    createlogger(args.verbose)

    logger.debug("{line} START {line}".format(line="-"*10))
    logger.debug("CLI arguments: {args}".format(args=args))
    logger.debug("Found these sections in INI: {sects}".format(sects=config.sections()))

    # Set the absolute path, so we always resolve correctly:
    config.set('Common', 'abspath', _abspath)

    logger.debug("""Environment:
    absolute path={path}
    xhtmldir={xhtmldir}
    fodir={fodir}
    """.format(path=_abspath, **dict(config["XSLT1"].items()) ))
    
    return parser, args


def __test():
    import doctest
    doctest.testmod()

    
if __name__=="__main__":
    import configparser
    try:
        parser, args = main()
        initenv(parser, args)
        
    except configparser.InterpolationMissingOptionError as error:
        logger.critical(error)
        sys.exit(10)
    
    if args.test:
        internaltest()
    
    logger.debug("{line} END {line}".format(line="-"*10))

# EOF