# -*- coding: UTF-8 -*-

import sys
import os, os.path

from .log import trace, logger
from .config import config

@trace(logger)
def initenv(parser, args=None):
    from shutil import copytree, rmtree
    
    # We use os.path.normpath here to avoid problems with a trailing slash later
    builddir=os.path.normpath(config.get('Common', 'builddir'))
    tempdir=os.path.normpath(config.get('Common', 'tempdir'))
    htmlbuilddir=os.path.normpath(os.path.join(builddir, "html"))
    cssdir=os.path.normpath(config.get('XSLT2', 'cssdir'))
    jsdir=os.path.normpath(config.get('XSLT2', 'jsdir'))
    pngdir=os.path.normpath(config.get('Common', 'pngdir'))
    highlighterdir=os.path.normpath(config.get('Common', 'highlighterdir'))
    
    if os.path.exists(builddir) and args.init:
        logger.debug(" Removing {builddir}".format(**locals()))
        rmtree(builddir)
    
    for entry in (builddir, htmlbuilddir, tempdir):
        os.makedirs(entry, exist_ok=True)
        logger.debug(" Created {entry}...".format(**locals()))

    pwd=os.getcwd()
    os.chdir(htmlbuilddir)
    
    # HINT:
    # The os.path.split function expects no trailing slash, so every path
    # is "normalized".
    # For example, the path="...images/png/" leads with os.path.split(path)[-1] -> ''
    # whereas path="...iamges/png" leads to 'png' (which is the expected result)
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
