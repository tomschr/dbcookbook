#!/bin/bash

source bin/common.sh

ARCHIVENAME="docookbook"
VERSION=$(xml sel -N d=${DB5NS} -t -v \
  "/d:book/d:info/d:releaseinfo[@role='archive']" \
  ${XMLIN})
ARCHIVE=$ARCHIVENAME-$VERSION



cat << EOF > $HTMLOUT/exclude.txt
exclude.txt
*.orig
*~
EOF

pushd $HTMLOUT >/dev/null
zip --log-info --suffixes .png:.jpg -Xr9D  * -x@exclude.txt \
    --out $BUILDDIR/$ARCHIVE.zip
popd  >/dev/null