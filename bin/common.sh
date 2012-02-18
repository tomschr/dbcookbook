#!/bin/bash
# Common code

# Get the absolute path of this script:
ABSPATH=$(dirname $(readlink -f ${BASH_SOURCE[0]}))
# Cut the last directory part, as script is in .../bin
ABSPATH=${ABSPATH%/*}
# 
BUILDDIR=${ABSPATH}/build
FRAMEWORKSDIR=${ABSPATH}/frameworks
BASEXSLT2=${FRAMEWORKSDIR}/xslt2/base
BASEXSLT1=${FRAMEWORKSDIR}/xslt/
DBXSLT5="/usr/share/xml/docbook/stylesheet/nwalsh5/current"
DBXSLT="/usr/share/xml/docbook/stylesheet/nwalsh/current"

XMLIN="en/xml/DocBook-Cookbook.xml"
SINGLEHTMLOUT=${BUILDDIR}/html/DoCookBook.html
CATALOGPROP="CatalogManager.properties"

HLCONFIG="${DBXSLT5}/highlighting/xslthl-config.xml"
HLFLAG="-Dxslthl.config=file://${HLCONFIG}"
XINCLUDEFLAG="-Dorg.apache.xerces.xni.parser.XMLParserConfiguration=org.apache.xerces.parsers.XIncludeParserConfiguration"

echo "Using Framework: $FRAMEWORKSDIR"
