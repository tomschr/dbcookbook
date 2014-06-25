# -*- coding: UTF-8 -*-

import os
from .log import logger, trace
        
def internaltest():
    from .config import MAINFILE, LOGFILE

    @trace(logger)
    def test_logger(a, b=5, c=10, x=None):
        pass
    logger.warn("Oha! This is %(file)s in %(package)s", dict(file=__file__, package=__package__))

    # logger.debug('logfile=%(logfile)s', dict(logfile=LOGFILE))
    logger.debug('debug message')
    logger.info('info message')
    logger.warn('warn message')
    logger.error('error message')
    logger.critical('critical message')
    test_logger(55)
    logger.debug("-------")
    test_logger(x=100, a=10)
    
    logger.debug("Testing if MAINFILE({main}) exists={result}".format(
        main=MAINFILE,
        result=os.path.exists(MAINFILE),
        ))

# EOF