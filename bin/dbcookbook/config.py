# -*- coding: UTF-8 -*-

import os, os.path

__author__ = "Thomas Schraitle"
__version__ = "0.5"
__docformat__ = "epytext"


# Where to write logfiles:
LOGFILE='/var/tmp/%s.log' % os.path.splitext(os.path.basename(__package__))[0]

# Our main XML file:
MAINFILE="en/xml/DocBook-Cookbook.xml"

# INI config file for configparser:
CONFIGFILE=".dbcookbook.ini"

# About this Sourceforge project:
SFPROJECT={
 'user':    'tom_schr',
 'project': 'doccookbook',
 'site':    'frs.sourceforge.net',
 # 'path':    '/home/frs/project/${SFPROJECT}',
}
SFPROJECT['path']='/home/frs/project/{project}'.format(**SFPROJECT)


