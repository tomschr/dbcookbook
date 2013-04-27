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

ARGS=$(getopt -o h,2,3,v -l help,epub2,epub3,verbose -- "$@")
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
    --)
      shift
      break
      ;;  
  esac
  shift
done

[[ -e ${EPUBPATH} ]] && rm -rf ${EPUBPATH}

xsltproc --xinclude --stringparam base.dir ${EPUBPATH} \
         ${DB2EPUB} \
         ${XMLIN}
RESULT=$?

if [[ $FORMAT = "2" ]]; then
  echo -n "application/epub+zip" > ${EPUBPATH}/mimetype
fi

mkdir -p ${EPUBPATH}/OEBPS/img/png
cp ${VERBOSE:+-v} images/png/*.png ${EPUBPATH}/OEBPS/img/png
cp ${VERBOSE:+-v} images/*.png ${EPUBPATH}/OEBPS/img

(cd ${EPUBPATH}
[[ -e ../${EPUB} ]] && rm ../${EPUB}
zip -${VERBOSE:+v}0X   ../${EPUB} mimetype
zip -${VERBOSE:+v}Xr9D ../${EPUB} META-INF OEBPS
)

${EPUBCHECK} build/${EPUB}
