#!/bin/bash
# Common code

# Get the absolute path of this script:
ABSPATH=$(dirname $(readlink -f ${BASH_SOURCE[0]}))
# Cut the last directory part, as script is in .../bin
ABSPATH=${ABSPATH%/*}
# 
BUILDDIR="build"
FRAMEWORKSDIR=${ABSPATH}/frameworks

echo "Framework: $FRAMEWORKSDIR"
