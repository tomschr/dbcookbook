#!/usr/bin/python3
# -*- coding: UTF-8 -*-

import sys
import os

import argparse
import logging

from dbcookbook import logger, trace, internaltest, createlogger, parsecommandline
from dbcookbook.config import LOGFILE, MAINFILE, CONFIGFILE
from dbcookbook.config import __version__


BINDIR=os.path.dirname(os.path.abspath(__file__))



def main():
    parser, args=parsecommandline()
    createlogger(args.verbose)
    return parser, args



def __test():
    import doctest
    doctest.testmod()

    
if __name__=="__main__":
        
    parser, args = main()
    
    logger.debug("CLI arguments: {args}".format(args=args))
    
    if args.test:
        internaltest()

# EOF