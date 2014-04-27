# -*- coding: UTF-8 -*-

import sys
import os, os.path

from .log import trace, logger
from .config import config

@trace(logger)
def initenv(parser, args=None):
    from shutil import copytree, rmtree
    builddir=config.get('Common', 'builddir')
    tempdir=config.get('Common', 'tempdir')
    htmlbuilddir=os.path.join(builddir, "html")
    cssdir=config.get('XSLT2', 'cssdir')
    jsdir=config.get('XSLT2', 'jsdir')
    pngdir=config.get('Common', 'pngdir')
    highlighterdir=config.get('Common', 'highlighterdir')
    
    if os.path.exists(builddir) and args.init:
        logger.debug(" Removing {builddir}".format(**locals()))
        rmtree(builddir)
    else:
        # logger.debug(" Creating {builddir}...".format(**locals()))
        for entry in (builddir, htmlbuilddir, tempdir):
            os.makedirs(entry, exist_ok=True)
            logger.debug(" Created {entry}...".format(**locals()))

    pwd=os.getcwd()
    os.chdir(htmlbuilddir)
    
    for path in (cssdir, jsdir, pngdir):
        src=os.path.relpath(path)
        dest=os.path.split(path)[-1]
        logger.debug(" Trying to symlink {path} ({src}) -> {dest}".format(**locals()) )
        try:
            os.symlink(src, dest, target_is_directory=True)
            logger.debug(" Created symlink: {src} -> {dest}".format(**locals()) )
        except FileExistsError:
            logger.debug(" Symlink {src} already found.".format(**locals()))        
    
    try:
        dest=os.path.join(htmlbuilddir, "highlighter")
        copytree(highlighterdir, dest)
        logger.debug(" Copied tree: {highlighterdir} -> {dest}".format(**locals()))
    except FileExistsError:
            pass

    
       
    os.chdir(pwd)
