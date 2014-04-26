#!/usr/bin/python3
# -*- coding: UTF-8 -*-

import sys
import os

import argparse
import logging

from dbcookbook import logger, trace, internaltest, createlogger, parsecommandline
from dbcookbook.config import config
from dbcookbook.config import __version__


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

@trace(logger)
def initenv(parser, args=None):
    from shutil import copytree, rmtree
    builddir=config.get('Common', 'builddir')
    htmlbuilddir=os.path.join(builddir, "html")
    cssdir=config.get('XSLT2', 'cssdir')
    jsdir=config.get('XSLT2', 'jsdir')
    pngdir=config.get('Common', 'pngdir')
    highlighterdir=config.get('Common', 'highlighterdir')
    
    if os.path.exists(builddir) and args.init:
        logger.debug(" Removing {builddir}".format(**locals()))
        rmtree(buildir)
    else:
        logger.debug(" Creating {builddir}...".format(**locals()))
        os.makedirs(builddir, exist_ok=True)
        os.makedirs(htmlbuilddir, exist_ok=True)

    pwd=os.getcwd()
    os.chdir(htmlbuilddir)
    
    for path in (cssdir, jsdir, pngdir):
        rp = os.path.relpath(path)
        try:
            os.symlink(rp, os.path.join(htmlbuilddir, path))
        except FileExistsError:
            pass
        logger.debug(" Created symlink: {rp} -> {path}".format(
            #p=os.path.join(htmlbuilddir, path), 
            **locals()) )
    
    try:
        copytree(highlighterdir, os.path.join(htmlbuilddir, "highlighter") )
    except FileExistsError:
            pass
    logger.debug(" Copy tree: {highlighterdir} -> {dest}".format(
        dest=os.path.join(htmlbuilddir, "highlighter"), 
        **locals()))
       
    os.chdir(pwd)
    
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