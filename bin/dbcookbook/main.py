#
#

import os

from dbcookbook.config import config
from dbcookbook.cli import parsecommandline
from dbcookbook.log import logger, createlogger


_abspath=os.path.abspath(os.path.join(os.path.dirname(__file__), '../..'))+"/"


def main():
    parserobj, args = parsecommandline()
    createlogger(args.verbose)

    logger.debug("CLI arguments: {args}".format(args=args))
    logger.debug("Found these sections in INI: {sects}".format(sects=config.sections()))

    # Set the absolute path, so we always resolve correctly:
    config.set('Common', 'abspath', _abspath)

    logger.debug("""Environment:
    absolute path={path}
    xhtmldir={xhtmldir}
    fodir={fodir}
    """.format(path=_abspath, **dict(config["XSLT1"].items()) ))

    logger.debug("Subcommand: %s", args.subcmd)
    result = args.func(parserobj, args)

    return result
