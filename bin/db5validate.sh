#!/bin/bash

# set -x

function usage() {
echo -e "$0\nValidates DocBook 5 project files (with automatic XInclude resolution)\n"
exit 1
}


case $1 in
  -h|--help) usage;;
esac


[ -e common.sh ] && . common.sh
[ -e bin/common.sh ] && . bin/common.sh

DBFILE="en/xml/DocBook-Cookbook.xml"
OUTFILE=${BUILDDIR}/${DBFILE##*/}

# xmllint --xinclude --output ${OUTFILE}  ${DBFILE}
JING_FLAGS="-Dorg.apache.xerces.xni.parser.XMLParserConfiguration=org.apache.xerces.parsers.XIncludeParserConfiguration"

ADDITIONAL_FLAGS="${JING_FLAGS}" jing -c ${FRAMEWORKSDIR}/rng/5.1/dbref.rnc ${DBFILE} && \
  echo "Ok, document ${DBFILE} is valid."
