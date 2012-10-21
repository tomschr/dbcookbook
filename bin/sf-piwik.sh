#!/bin/bash
# 
# Purpose:
#  Download statistical data from Piwik
#
# Author:
#  Thomas Schraitle <tom_schr AT web DOT de>
#
# Copyright 2012 by Thomas Schraitle
#
# TODO:
#  Add command line option parser

CONFIG="$HOME/.config/SourceForge/piwik.token"

# Include the TOKEN_AUTH
if [[ -e "$CONFIG" ]]; then
 source "$CONFIG"
else
 echo "No config $CONFIG found"
 exit 10
fi

# Our parameters
URL='https://sourceforge.net/apps/piwik/doccookbook/index.php?module=API'
METHOD="Actions.getPageTitles"
FORMAT="Html"
IDSITE="1"
DATE="today"
PERIOD="month"
FILTER_LIMIT="100"
FILEXT=$(echo $FORMAT | tr "[:upper:]" "[:lower:]")
METHODLOWER=$(echo $METHOD | tr "[:upper:]" "[:lower:]")
OUTPUT="$METHOD-$DATE.$FILEXT"

# Concat our parameters
PARAMS="&method=$METHOD&format=$FORMAT&idSite=$IDSITE&period=$PERIOD"\
"&date=$DATE&token_auth=$TOKEN_AUTH&filter_limit=$FILTER_LIMIT"

# Download 
echo "Downloading $URL$PARAMS..."
wget "$URL$PARAMS" --output-document="$OUTPUT"

# EOF