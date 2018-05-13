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
    htmlbuilddir=os.path.normpath(config.get('Common', 'htmldir'))
    fobuilddir=os.path.normpath(config.get('Common', 'fodir'))
    cssdir=os.path.normpath(config.get('XSLT2', 'cssdir'))
    jsdir=os.path.normpath(config.get('XSLT2', 'jsdir'))
    pngdir=os.path.normpath(config.get('Common', 'pngdir'))
    highlighterdir=os.path.normpath(config.get('Common', 'highlighterdir'))
    
    if os.path.exists(builddir) and args.init:
        logger.debug(" Removing {builddir}".format(**locals()))
        rmtree(builddir)
    
    for entry in (builddir, htmlbuilddir, fobuilddir, tempdir):
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

    copyexamples()
    os.chdir(pwd)


def copyexamples():
    from shutil import copytree, Error, ignore_patterns, copy2
    from os.path import isfile, islink
    from fnmatch import fnmatch

    htmlbuilddir=os.path.normpath(config.get('Common', 'htmldir'))
    xmldir=os.path.normpath(config.get('Common', 'xmldir'))
    examples='examples'

    logger.debug(" Trying to create {examples} directory".format(**locals()))
    os.makedirs(os.path.join(htmlbuilddir, examples), exist_ok=True)

    def mycopy(src, dst, *, follow_symlinks=True):
        logger.info("Copying {src} -> {dst}".format(**locals()))
        copy2(src, dst, follow_symlinks=follow_symlinks)

    subdirs=getsubdirs()
    for d in subdirs:
        dest=os.path.join(htmlbuilddir, examples, d)
        src=os.path.join(xmldir, d)

        logger.debug(" Trying to copy {src} -> {dest}".format(**locals()))
        try:
            res = copytree(src, dest,
                           copy_function=mycopy,
                           ignore=ignore_patterns("*~", "*.bak", "*.orig", "defs.xml", "png") )
        except FileExistsError as e:
            # logger.info("File already exists {e}".format(**locals()))
            pass
        except Error as e:
            logger.debug(" Shutils Error: {e}".format(**locals()))


def getsubdirs():
    """Get all directories which are used in our main XML file and below

    Return found subdirs
    """
    from lxml import etree
    from itertools import chain

    namespaces={ 't': "urn:x-toms:docbook-ext",
                 'd': "http://docbook.org/ns/docbook",
                 'xl': "http://www.w3.org/1999/xlink" }
    builddir=os.path.normpath(config.get('Common', 'builddir'))
    tempdir=os.path.normpath(config.get('Common', 'tempdir'))
    xmldir=os.path.normpath(config.get('Common', 'xmldir'))
    mainfile=config.get('DEFAULT', 'mainbasefile')

    xmlparser = etree.XMLParser(ns_clean=True)
    tree = etree.parse(os.path.join(xmldir, mainfile), xmlparser)
    tree.xinclude()

    fn = tree.xpath("//t:output/t:filename", namespaces=namespaces)
    xmlbase = [ i.xpath("//d:*/@xml:base", namespaces=namespaces)  for i in fn ]

    # We use chain here to avoid nested lists (or in other words: we need a flatted lists)
    res=set([ os.path.split(i)[0] for i in chain(*xmlbase) ])
    logger.debug(" Found subdirectories: {res}".format(**locals()))

    return res
# EOF
