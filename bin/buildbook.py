#!/usr/bin/python3
# -*- coding: UTF-8 -*-

import sys
import os

import argparse
import logging

from dbcookbook import logger, trace, internaltest, createlogger, parsecommandline
from dbcookbook.config import config
from dbcookbook.config import __version__


_abspath=os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))


def main():
    parser, args=parsecommandline()
    createlogger(args.verbose)

    logger.debug("Found these sections = {sects}".format(sects=config.sections()))
    
    # Set the absolute path, so we always resolve correctly:
    config.set('Common', 'abspath', _abspath)
    
    logger.debug("{line} START {line}".format(line="-"*10))
    logger.debug("CLI arguments: {args}".format(args=args))
    logger.debug("Abspath={path}".format(
        path=_abspath,  #os.path.abspath(os.path.dirname(__file__)),
        ))
    logger.debug("framework={fw}".format(
        fw=config.get('Common', 'framework')
        ))
    
    return parser, args



def __test():
    import doctest
    doctest.testmod()

    
if __name__=="__main__":
    parser, args = main()
    
    if args.test:
        internaltest()
    
    logger.debug("{line} END {line}".format(line="-"*10))

# EOF