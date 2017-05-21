#!/bin/bash

[ -e common.sh ] && . common.sh
[ -e bin/common.sh ] && . bin/common.sh


VERSION=0.6e
EPUB=DoCookBook-v${VERSION}.epub
EPUBCHECK=/local/repos/osp/autorenhinweise/tools/bin/osp-epubcheck
#XMLMAIN=en/xml/DocBook-Cookbook.xml
# Use EPUB2 as default
FORMAT=2
EPUBPATH=${BUILDDIR}/epub/
DB2EPUB=${FRAMEWORKSDIR}/xslt/epub/docbook.xsl

function usage() 
{
cat << EOF
Transforms our DocBook Document into EPUB

-h, --help         Prints this help text
-2, --epub2        Creates an EPUB2 file
-3, --epub3        Creates an EPUB3 file
-v, --verbose      Be more verbose
EOF
}

THEARGS="$@"

ARGS=$(getopt -o h,d,2,3,v -l help,debug,epub2,epub3,verbose -- "$@")
eval set -- "$ARGS"
while true ; do
  case "$1" in
    -h|--help)
      usage
      exit 1
      ;;
    -2|--epub2)
      # 
      ;;
    -3|--epub3)
      FORMAT=3
      EPUBPATH=${BUILDDIR}/epub3/
      DB2EPUB=${FRAMEWORKSDIR}/xslt/epub3/chunk.xsl
      ;;
    --verbose|-v)
      VERBOSE=1
      ;;
    -d|--debug)
      DEBUG_SCRIPT=1
      ;;
    --)
      shift
      break
      ;;  
  esac
  shift
done

[[ -e ${EPUBPATH} ]] && rm -rf ${EPUBPATH}

my_debug "DocCookBook to EPUB${FORMAT}"
my_debug "  Arguments: ${THEARGS}"

my_debug "Transforming DocBook file into EPUB${FORMAT}..."
x="xsltproc --xinclude \
        --stringparam base.dir ${EPUBPATH} \
        ${DB2EPUB} \
        ${XMLIN}"
my_debug $x
$x
RESULT=$?

if [[ $FORMAT = "2" ]]; then
  my_debug "Creating mimetype file..."
  echo -n "application/epub+zip" > ${EPUBPATH}/mimetype
fi

my_debug "Copying pictures..."
mkdir -p ${EPUBPATH}/OEBPS/img/png
cp ${VERBOSE:+-v} images/png/*.png ${EPUBPATH}/OEBPS/img/png
# cp ${VERBOSE:+-v} images/*.png ${EPUBPATH}/OEBPS/img

my_debug "Creating EPUB${FORMAT} archive..."
(cd ${EPUBPATH}
[[ -e ../${EPUB} ]] && rm ../${EPUB}
zip -${VERBOSE:+v}0X   ../${EPUB} mimetype
zip -${VERBOSE:+v}Xr9D ../${EPUB} META-INF OEBPS
)

my_debug "Validating file..."
${EPUBCHECK} build/${EPUB}
