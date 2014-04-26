# -*- coding: UTF-8 -*-

import os, os.path

__author__ = "Thomas Schraitle"
__version__ = "0.5"
__docformat__ = "epytext"


#
LOGFILE='/var/tmp/%s.log' % os.path.splitext(os.path.basename(__package__))[0]

#
MAINFILE="en/xml/DocBook-Cookbook.xml"

#
CONFIGFILE=".dbcookbook.ini"