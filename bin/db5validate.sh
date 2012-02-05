#!/bin/bash

[ -e common.sh ] && . common.sh
[ -e bin/common.sh ] && . bin/common.sh

DBFILE="en/xml/DocBook-Cookbook.xml"
OUTFILE=${BUILDDIR}/${DBFILE##*/}

# xmllint --xinclude --output ${OUTFILE}  ${DBFILE}
JING_FLAGS="-Dorg.apache.xerces.xni.parser.XMLParserConfiguration=org.apache.xerces.parsers.XIncludeParserConfiguration"

ADDITIONAL_FLAGS="${JING_FLAGS}" jing -c ${FRAMEWORKSDIR}/rng/5.1/dbref.rnc ${OUTFILE} && \
  echo "Ok, document ${DBFILE} is valid."
