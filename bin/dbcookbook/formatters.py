# -*- coding: UTF-8 -*-

from types import FunctionType as __func
from .log import trace, logger

# __all__=[ ]

# This is a placeholder variable
extension="_formatter"
funcname="{{}}{}".format(extension)
default_fo="fop"

def axf_formatter(parser, args):
    """Format with Antenna House Formatter"""
    parser.error("AXF is not implemented yet. Sorry, try a different formatter")


def fop_formatter(parser, args):
    """Format with Apache's FOP"""
    logger.info("Rendering with FOP")


def xep_formatter(parser, args):
    """Format with RenderX XEP"""
    logger.info("Rendering with XEP")


# Fill __all__ with all formatters which are functions
_L=locals()
__all__ = [ i for i in locals() if i.endswith(extension) ]
__all__ = [ i for i in __all__ if type(_L[i]) is __func  ]
del _L

supported=[ i.split(extension)[0] for i in __all__ if i.endswith(extension) ]

logger.debug("Found formatters: {}".format(__all__))
