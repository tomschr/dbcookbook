# -*- coding: UTF-8 -*-

import sys
import os, os.path
from functools import wraps
import inspect
import logging

# Need to be global to make use of it in trace decorator
logger = logging.getLogger(os.path.basename(__package__))


class trace(object):
    '''Logging decorator that allows you to log with a specific logger.
    
    To be used as:
    
    @trace(logger)
    def test_logger(a, b=5, c=10, x=None):
        pass
    '''    
    
    # Customize these messages
    ENTRY_MESSAGE = '[ Entering {}{sig} called with args={args},  kwargs={kwargs}]'
    EXIT_MESSAGE =  '[ Exiting  {}(), returned {result} ]'

    def __init__(self, logger=logger):
        self.logger = logger

    def __call__(self, func, enable=True):
        '''Returns a wrapper that wraps func.
        The wrapper will log the entry and exit points of the function
        with logging.INFO level.
        '''
        # set logger if it was not set earlier
        if not self.logger:
            logging.basicConfig()
            self.logger = logging.getLogger(func.__module__)

        if not enable:
            return func

        @wraps(func)
        def logwrap(*args, **kwargs):
            sig=inspect.signature(func)
            
            #argresult = []
            #for name, param in sig.parameters.items():
            #    # print(name, param.kind, param.default)
            #    if param.kind == inspect.Parameter.POSITIONAL_ONLY:
            #        argument = '{}'.format(name)
            #    elif param.kind == inspect.Parameter.POSITIONAL_OR_KEYWORD:
            #        if param.default != inspect.Parameter.empty:
            #            argument = '{}={!r}'.format(name, param.default)
            #        else:
            #            argument = '{}'.format(name)
            #    elif param.kind == inspect.Parameter.VAR_POSITIONAL:
            #        argument = '*{}'.format(name)
            #
            #    elif param.kind == inspect.Parameter.KEYWORD_ONLY:
            #        if param.default != inspect.Parameter.empty:
            #            argument = '{}={!r} (keyword-only)'.format(name, param.default)
            #        else:
            #            argument = '{} (keyword-only)'.format(name)
            #
            #    elif param.kind == inspect.Parameter.VAR_KEYWORD:
            #        argument = '**{}'.format(name)
            #
            #    argresult.append(argument)


            self.logger.debug(self.ENTRY_MESSAGE.format(func.__name__, 
                sig=str(sig), 
                args=str(args), 
                kwargs=kwargs)
                # "  \n".join(argresult)
                )
            # self.logger.debug("  Full spec:{}".format(inspect.getfullargspec(func)))

            f_result = func(*args, **kwargs)

            self.logger.debug(self.EXIT_MESSAGE.format(func.__name__, result=f_result))
            return f_result
        return logwrap


def createlogger(level):
    from .config import LOGFILE

    maptable = {
        0: logging.WARNING,
        1: logging.INFO,
        2: logging.DEBUG,
        }
        
    # Map the verbose level from argparse to log level:
    loglevel=maptable.get(level, logging.NOTSET)
    
    # Set the global level, we want to see "all":
    logger.setLevel(logging.DEBUG)
    # create file handler which logs even debug messages
    fh = logging.FileHandler(LOGFILE)
    fh.setLevel(logging.DEBUG)
    
    # create console handler with our log level from verbose option
    ch = logging.StreamHandler()
    # But change for the console handler the current loglevel
    ch.setLevel(loglevel)
    
    # create formatter and add it to the handlers
    formatter = logging.Formatter('{levelname}: {message}', style='{')
    ch.setFormatter(formatter)
    
    formatter = logging.Formatter('{asctime} {levelname:8s}: {funcName}: {message}', style='{')
    fh.setFormatter(formatter)
    
    # add the handlers to logger
    logger.addHandler(ch)
    logger.addHandler(fh)

# EOF
