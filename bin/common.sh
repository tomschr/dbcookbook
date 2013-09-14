#!/bin/bash
# Common code

# Get the absolute path of this script:
ABSPATH=$(dirname $(readlink -f ${BASH_SOURCE[0]}))
# Cut the last directory part, as script is in .../bin
ABSPATH=${ABSPATH%/*}
# 
BUILDDIR=${ABSPATH}/build
FRAMEWORKSDIR=${ABSPATH}/frameworks
CATEGORYXSL=${FRAMEWORKSDIR}/xslt/misc/resolvecategories.xsl
BASEXSLT2=${FRAMEWORKSDIR}/xslt2/base
BASEXSLT1=${FRAMEWORKSDIR}/xslt/
CSSFILE=${BASEXSLT2}/css/dbcookbook.css
DBXSLT5="/usr/share/xml/docbook/stylesheet/nwalsh5/current"
DBXSLT="/usr/share/xml/docbook/stylesheet/nwalsh/current"
DB5NS="http://docbook.org/ns/docbook"


DEBUG_SCRIPT=
LOG=1
LOGFILE="/tmp/docookbook.log"

XMLIN="en/xml/DocBook-Cookbook.xml"
HTMLOUT="${BUILDDIR}/html"
SINGLEHTMLOUT="${HTMLOUT}/DoCookBook.html"
CATALOGPROP="CatalogManager.properties"

HLCONFIG="${DBXSLT5}/highlighting/xslthl-config.xml"
HLFLAG="-Dxslthl.config=file://${HLCONFIG}"
XINCLUDEFLAG="-Dorg.apache.xerces.xni.parser.XMLParserConfiguration=org.apache.xerces.parsers.XIncludeParserConfiguration"

function my_debug() {
# Syntax: my_debug "MESSAGE" [MORE ARGUMENTS...]
# Prints debug messages, if DEBUG_SCRIPT is non-empty
    if [[ "$DEBUG_SCRIPT" ]]; then
        echo "[debug] ${0}: $@" >&2;
    fi
}

function framework() {
 echo "Using Framework: $FRAMEWORKSDIR"
}

function __createlinks() {
  pushd ${HTMLOUT} 2>/dev/null
  [[ -e css ]] || ln -s ../../frameworks/xslt2/base/css
  [[ -e js ]]  || ln -s ../../frameworks/db-xslt2/xslt/base/js
  [[ -e png ]] || ln -s ../../images/png
  popd 2>/dev/null
}

function __logging() {
  local MSG=$1
  local DATE=$(date +"[%d-%m-%YT%H:%M:%S]")
  
  echo "$DATE $MSG" >> $LOGFILE
}

function exit_on_error() {
  local MSG=$1
  echo "ERROR: $MSG" 
  __logging "ERROR: $MSG"  
  exit 10
}

function createEntity() {
cat > ${BUILDDIR}/tmp/ents.ent <<EOF
<!ENTITY % amsa.ent SYSTEM "/usr/share/xml/entities/xmlcharent/0.3/iso-amsa.ent">
%amsa.ent;
<!ENTITY % amsb.ent SYSTEM "/usr/share/xml/entities/xmlcharent/0.3/iso-amsb.ent">
%amsb.ent;
<!ENTITY % amsc.ent SYSTEM "/usr/share/xml/entities/xmlcharent/0.3/iso-amsc.ent">
%amsc.ent;
<!ENTITY % amsn.ent SYSTEM "/usr/share/xml/entities/xmlcharent/0.3/iso-amsn.ent">
%amsn.ent;
<!ENTITY % amso.ent SYSTEM "/usr/share/xml/entities/xmlcharent/0.3/iso-amso.ent">
%amso.ent;
<!ENTITY % amsr.ent SYSTEM "/usr/share/xml/entities/xmlcharent/0.3/iso-amsr.ent">
%amsr.ent;
<!ENTITY % box.ent SYSTEM "/usr/share/xml/entities/xmlcharent/0.3/iso-box.ent">
%box.ent;
<!ENTITY % cyr1.ent SYSTEM "/usr/share/xml/entities/xmlcharent/0.3/iso-cyr1.ent">
%cyr1.ent;
<!ENTITY % cyr2.ent SYSTEM "/usr/share/xml/entities/xmlcharent/0.3/iso-cyr2.ent">
%cyr2.ent;
<!ENTITY % dia.ent SYSTEM "/usr/share/xml/entities/xmlcharent/0.3/iso-dia.ent">
%dia.ent;
<!ENTITY % grk1.ent SYSTEM "/usr/share/xml/entities/xmlcharent/0.3/iso-grk1.ent">
%grk1.ent;
<!ENTITY % grk2.ent SYSTEM "/usr/share/xml/entities/xmlcharent/0.3/iso-grk2.ent">
%grk2.ent;
<!ENTITY % grk3.ent SYSTEM "/usr/share/xml/entities/xmlcharent/0.3/iso-grk3.ent">
%grk3.ent;
<!ENTITY % grk4.ent SYSTEM "/usr/share/xml/entities/xmlcharent/0.3/iso-grk4.ent">
%grk4.ent;
<!ENTITY % lat1.ent SYSTEM "/usr/share/xml/entities/xmlcharent/0.3/iso-lat1.ent">
%lat1.ent;
<!ENTITY % lat2.ent SYSTEM "/usr/share/xml/entities/xmlcharent/0.3/iso-lat2.ent">
%lat2.ent;
<!ENTITY % num.ent SYSTEM "/usr/share/xml/entities/xmlcharent/0.3/iso-num.ent">
%num.ent;
<!ENTITY % pub.ent SYSTEM "/usr/share/xml/entities/xmlcharent/0.3/iso-pub.ent">
%pub.ent;
<!ENTITY % tech.ent SYSTEM "/usr/share/xml/entities/xmlcharent/0.3/iso-tech.ent">
%tech.ent;
EOF
}
