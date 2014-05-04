# -*- coding: UTF-8 -*-


def parsecommandline():
    """Parses commandline and returns parser and parsed arguments
    
    @return: tuple of (parser object, parsed arguments)
    """
    import argparse
    from .config import __version__, __author__, LOGFILE, MAINFILE

    parser = argparse.ArgumentParser(
        description='Transforms an DocBook XML file into a target format',
    )

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
        default=None,
        )
    parser.add_argument('mainfile',
        help="Use main XML file  (default: %(default)s)",
        default=MAINFILE,
        nargs='?',
        )
    # Should go away as soon as the script is stable
    parser.add_argument('--test',
        help="Just for testing",
        action='store_true',
        default=False,
        )
    
    args=parser.parse_args()
    
    if args.jobs < 0:
        parser.error("argument -j/--job: negative int value: {}. "
                     "Job values have to be positive.".format(args.jobs))
        
    return parser, args
