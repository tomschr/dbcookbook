# -*- coding: UTF-8 -*-

import sys
import os, os.path
import shlex

from .config import config
from .log import trace, logger
from .utils import execute

from lxml import etree


def consistencycheck(dirs):
    """Checks if all directories in dirs are available, 
       otherwise raise FileNotFoundError
    """
    for d in dirs:
        logger.info("Checking for {}".format(d))
        if not os.path.exists(d):
            raise FileNotFoundError("Expected directory {} not found".format(d))

def get_html_paths(folder, rootid=None):
    """Returns iterator of one or more entries. 
       If rootid is set, return only one single entry '{rootid}.html'
    """
    if rootid:
        htmlfiles = [ "{rootid}.html".format(**locals()) ]
        logger.info("Using rootid={rootid} with file {htmlfiles[0]}".format(**locals()))
    else:
        import glob
        pwd=os.getcwd()
        os.chdir(folder)
        htmlfiles = iter(glob.glob("*.html".format(**locals())))
        os.chdir(pwd)
        
    return htmlfiles
    

#@trace(logger)
def cleanup_parallel(parser, args):
    pass


@trace(logger)
def cleanup(parser, args):
    """xsltproc --nonet --novalid -o ${HTMLOUTPUT} \
   ${BASEXSLT1}/misc/html2cleanhtml.xsl \
   ${HTMLINPUT}
    """
    tempdir=os.path.normpath(config.get('Common', 'tempdir'))
    htmldir=os.path.normpath(config.get('Common', 'htmldir'))
    cleanhtml=config.get('XSLT1', 'cleanhtml')
    
    # Consistency check
    consistencycheck( (tempdir, htmldir) )
    
    # Populate all files
    htmlfiles = get_html_paths(tempdir, args.rootid)
        
    xmlparser = etree.XMLParser(
        dtd_validation=False,  # use default (False)
        no_network=False,
        ns_clean=True,
        )
    
    transform = etree.XSLT(etree.parse(cleanhtml))
    for entry in htmlfiles:
        logger.info("Cleaning up '{entry}'...".format(**locals()))
        resultfile=os.path.join(htmldir, entry)
        params={}
        xmldoc = etree.parse( os.path.join(tempdir, entry), xmlparser)
        resulttree = transform(xmldoc, **params)
        
        #logger.debug("-- Return from XSLT processor (Start) --")
        for e in transform.error_log:
            logger.debug("{e.message}".format(**locals()))
        #logger.debug("-- Return from XSLT processor (End) --")
        
        logger.debug("Writing result from cleanup to '{resultfile}'".format(**locals()))
        resulttree.write( resultfile, 
                          method="xml",
                          encoding="UTF-8",
                          standalone=True,
                         )

@trace(logger)
def singlehtml(parser, args):
    """Tranform XML input and generate single HTML page
    """
    basefile=os.path.basename(args.mainfile)
    tempdir=config.get('Common', 'tempdir')
    xmlfile = os.path.join(tempdir, basefile)
    xhtmlsingle = config.get('XSLT1', 'xhtmlsingle')
    htmlfile = config.get('Common', 'htmlsingle')
    
    if not os.path.exists(xmlfile):
        raise FileNotFoundError("File {xmlfile} not found".format(**locals()))

    xmlparser = etree.XMLParser(
        # dtd_validation=False,  # use default (False)
        ns_clean=True)
    xmldoc = etree.parse(xmlfile, xmlparser)
    transform = etree.XSLT(etree.parse(xhtmlsingle))
    
    logger.info("*** Transforming {xmlfile} with {xhtmlsingle}".format(**locals()))
    params = {
             #'base.dir':       etree.XSLT.strparam(tempdir),
             'use.extensions': etree.XSLT.strparam('0'),
             }
             
    if args.rootid:
         params.update(rootid=args.rootid)

    resulttree = transform(xmldoc, **params)
    
    logger.debug("-- Return from XSLT processor (Start) --")
    for entry in transform.error_log:
        logger.debug("{entry.message}".format(**locals()))
    logger.debug("-- Return from XSLT processor (End) --")

    resulttree.write(htmlfile)
    logger.info(">> Find the Single HTML in %r", htmlfile)

       
@trace(logger)
def chunkedhtml(parser, args):
    """Tranform XML input and generate chunked HTML pages
    """
    basefile=os.path.basename(args.mainfile)
    tempdir=config.get('Common', 'tempdir')
    xmlfile = os.path.join(tempdir, basefile)
    xhtmlchunk = config.get('XSLT1', 'xhtmlchunk')
    htmldir = config.get('Common', 'htmldir')

    if not os.path.exists(xmlfile):
        raise FileNotFoundError("File {xmlfile} not found".format(**locals()))

    xmlparser = etree.XMLParser(
        # dtd_validation=False,  # use default (False)
        ns_clean=True)
    xmldoc = etree.parse(xmlfile, xmlparser)
    transform = etree.XSLT(etree.parse(xhtmlchunk))

    logger.info("*** Transforming {xmlfile} with {xhtmlchunk}".format(**locals()))
    params = {
             'base.dir':       etree.XSLT.strparam(tempdir),
             'use.extensions': etree.XSLT.strparam('0'),
             }

    if args.rootid:
         params.update(rootid=args.rootid)
        
    resulttree = transform(xmldoc, **params)
    
    logger.debug("-- Return from XSLT processor (Start) --")
    for entry in transform.error_log:
        logger.info("{entry.message}".format(**locals()))
    logger.debug("-- Return from XSLT processor (End) --")

    logger.info(">> Find the HTML in %r", htmldir)
    

def html(parser, args):
    """Generate HTML files"""
    chunkedhtml(parser, args)
    singlehtml(parser, args)
    cleanup(parser, args)
    return 0


@trace(logger)
def fo2pdf(parser, args):
    """Generate PDF from FO"""
    import subprocess, shlex
    fobuilddir = os.path.normpath(config.get('Common', 'fodir'))
    fofile = os.path.join(fobuilddir, os.path.normpath(config.get('Common', 'fosingle')))

    # TODO: maybe there is a better method:
    version = subprocess.check_output(shlex.split("git describe"))
    version = version.decode("utf-8").strip()

    pdffile = args.output
    if pdffile is None:
        # pdffile = os.path.normpath(config.get('Common', 'pdf'))
        pdffile = os.path.join(fobuilddir,
                               config.get('Archive', 'pdffile').replace("@VERSION@", version))

    fmtcmd = {'fop': 'fop {opts} {fo} {pdf}',
              'xep': 'xep {opts} {fo} {pdf}',
              'axf': 'axf {opts} {fo} {pdf}',
              }
    cmd = fmtcmd[args.formatter].format(opts='' if args.opts is None else args.opts,
                                        fo=fofile,
                                        pdf=pdffile)
    logger.debug("Running %s with %s", args.formatter, cmd)
    execute(cmd)

    logger.debug(">>> Find PDF at %s", pdffile)
    return 0


def fo(parser, args):
    """Generate a FO file"""
    tempdir = os.path.normpath(config.get('Common', 'tempdir'))
    fobuilddir = os.path.normpath(config.get('Common', 'fodir'))
    fofile = os.path.join(fobuilddir, os.path.normpath(config.get('Common', 'fosingle')))
    foxslt = config.get('XSLT1', 'fosingle')
    basefile = os.path.basename(args.mainfile)
    xmlfile = os.path.join(tempdir, basefile)

    if not os.path.exists(xmlfile):
        raise FileNotFoundError("File {xmlfile} not found".format(**locals()))

    xmlparser = etree.XMLParser(
        # dtd_validation=False,  # use default (False)
        ns_clean=True
        )
    xmldoc = etree.parse(xmlfile, xmlparser)
    # xmldoc.xinclude()
    transform = etree.XSLT(etree.parse(foxslt))

    logger.info("*** Transforming {xmlfile} with {foxslt}".format(**locals()))
    params = {
             # 'base.dir':       etree.XSLT.strparam(fobuilddir),
             'use.extensions': etree.XSLT.strparam('0'),
             }

    if args.rootid:
        params.update(rootid=args.rootid)

    # Choose formatter extensions:
    formatterextensions = { f: {'{}.extension'.format('fop1' if f == 'fop' else f):
                                etree.XSLT.strparam('1')}
                           for f in ('fop', 'xep', 'axf')
                          }
    params.update(formatterextensions[args.formatter])
    resulttree = transform(xmldoc, **params)
    
    logger.debug("-- Return from XSLT processor (Start) --")
    for entry in transform.error_log:
        logger.debug("{entry.message}".format(**locals()))
    logger.debug("-- Return from XSLT processor (End) --")

    resulttree.write(fofile)
    logger.info("FO stored at %r", fofile)
    return fo2pdf(parser, args)


# EOF
