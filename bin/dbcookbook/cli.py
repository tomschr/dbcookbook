# -*- coding: UTF-8 -*-


def parsecommandline():
    """Parses commandline and returns parser and parsed arguments
    
    @return: tuple of (parser object, parsed arguments)
    """
    import argparse
    from .config import __version__, LOGFILE, MAINFILE

    parser = argparse.ArgumentParser(
        description='Transforms an DocBook XML file into a target format',
    )

    parser.add_argument('--version',
        action='version',
        version='%(prog)s v{0}'.format(__version__)
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
    
    return parser, parser.parse_args()
