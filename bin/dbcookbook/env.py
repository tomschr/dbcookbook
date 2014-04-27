# -*- coding: UTF-8 -*-

import sys
import os, os.path

from .log import trace, logger
from .config import config

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
