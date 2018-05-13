#!/usr/bin/python3
# -*- coding: UTF-8 -*-

import sys
import os

from dbcookbook.log import logger
from dbcookbook.main import main


def __test():
    import doctest
    doctest.testmod()

    
if __name__=="__main__":
    from configparser import InterpolationMissingOptionError
    from lxml.etree import XSLTApplyError, XSLTParseError
    from subprocess import CalledProcessError
    line="-"*10
    
    try:
        logger.debug("{line} START {line}".format(**locals()))
        result = main()
        
    except (InterpolationMissingOptionError, 
            # NameError, 
            XSLTApplyError,
            XSLTParseError,
            FileNotFoundError,
            CalledProcessError
           ) as error:
        logger.critical("{cls}: {error}".format(cls=error.__class__.__name__,
                                                error=error))
        sys.exit(10)
    
    #if obj[1].test:
    #    from dbcookbook import internaltest
    #    internaltest()
    
    logger.info("Success!")
    # logger.info("Find the result at: ")
    logger.debug("{line} END {line}".format(**locals()))

    sys.exit(result)

# EOF
