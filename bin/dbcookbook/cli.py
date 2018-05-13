# -*- coding: UTF-8 -*-

from dbcookbook.categories import resolvecategories
from dbcookbook.env import initenv
from dbcookbook.formats import html, fo
from dbcookbook.log import logger
from dbcookbook.zip import createzip


def func_html(parserobj, args):
    logger.debug("-- Create HTML with %s --" % args)
    initenv(parserobj, args)
    resolvecategories(parserobj, args)
    result = html(parserobj, args)
    if args.archive:
        result = createzip(parserobj, args)
    else:
        logger.info("Skipping compressed archive creation")
    return result


def func_pdf(parserobj, args):
    logger.debug("-- Create PDF with %s --", args)
    initenv(parserobj, args)
    return fo(parserobj, args)


def parsecommandline():
    """Parses commandline and returns parser and parsed arguments
    
    @return: tuple of (parser object, parsed arguments)
    """
    import argparse
    from .config import __version__, __author__, LOGFILE, MAINFILE

    mainfile = dict(help="Use main XML file  (default: %(default)r)",
                     default=MAINFILE,
                     nargs='?',
                     )
    parser = argparse.ArgumentParser(
        description='Transforms an DocBook XML file into a target format',
    )
    # Subparsers
    sp = parser.add_subparsers(dest='subcmd', help='sub-command help')

    parser.add_argument('--version',
        action='version',
        version='%(prog)s v{0} by {1}'.format(__version__, __author__)
        )
    parser.add_argument('-v', '--verbose',
        action='count',
        default=0,
        help="Increase verbosity level (default: %(default)i)",
        )
    parser.add_argument('-L', '--log-file',
        help="Write logging information into LOGFILE (default: '%(default)s')",
        metavar="LOGFILE",
        default=LOGFILE,
        nargs='?',
        )
    parser.add_argument('-r', '--rootid',
        help="Formats only the element that contains an "
             "attribute with xml:id='$ROOTID' (default: %(default)s)",
        # type=str,
        nargs='?',
        )
    parser.add_argument('--cleanup',
        help="Only perform cleanup step (default: %(default)s)",
        action='store_true',
        default=False,
        )
    parser.add_argument('-I', '--init',
        help="Remove any old build directory before starting (default: %(default)s)",
        action='store_true',
        default=False,
        )
    parser.add_argument('-E', '--no-example',
        help="Do NOT generate examples automatically (default: %(default)s)",
        action='store_true',
        default=False,
        )
    parser.add_argument('-c', '--no-category',
        help="Do NOT generate other categories automatically (default: %(default)s)",
        action='store_true',
        default=False,
        )
    parser.add_argument('-j', '--jobs',
        help="Allow N jobs at once (default: %(default)s)",
        metavar='N',
        type=int,
        default=1,
        )

    # Should go away as soon as the script is stable
    parser.add_argument('--test',
        help="Just for testing",
        action='store_true',
        default=False,
        )

    # HTML Subparser
    htmlsub = sp.add_parser('html',
                            help='Generate HTML')
    # sp.set_defaults(subcommand=None)
    htmlsub.set_defaults(func=func_html)
    htmlsub.add_argument('-A', '--archive',
                         help=("Create compressed files of the HTML build "
                               "(default: %(default)s)"),
                         action='store_true',
                         default=False,
                         )
    htmlsub.add_argument('mainfile', **mainfile)

    # FO Subparser
    fosub = sp.add_parser('pdf',
                          help='Generate PDF from FO')
    fosub.set_defaults(func=func_pdf)
    fosub.add_argument('-f', '--formatter',
                       choices=('fop', 'xep'),  # axf
                       default='fop',
                       help='Format the FO with formatter (default %(default)r)',
                       )
    fosub.add_argument('-o', '--output',
                       # required=False,
                       help="Save result PDF in OUTPUT"
                       )
    fosub.add_argument('--opts',
                       help=("Pass special options to formatter; "
                             "keep in mind to quote it correctly")
                       )
    fosub.add_argument('mainfile', **mainfile)


    args=parser.parse_args()

    if args.jobs < 0:
        parser.error("argument -j/--job: negative int value: {}. "
                     "Job values have to be positive.".format(args.jobs))

    return parser, args
