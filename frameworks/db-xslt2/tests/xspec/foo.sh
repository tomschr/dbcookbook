#!/bin/bash

# Default catalog:
BASE_CATALOG="/etc/xml/catalog"
CATALOG_VERB=3

echo "Before: $@"
PARAMS=

while [[ ${1:0:1} = '-' ]]; do
   case "$1" in
    --catalogs=*)
      # PREREQUISITES: Each catalog file has to be separated with
      #                colon (:) or semicolon (;)
      # Strips the option:
      CATS=${1#--catalogs=}
      # Replace *all* ~/ with $HOME/ (the ~/ avoids any problems when
      # ~ occurs *after* a file (unlikely, but better safe than sorry):
      CATS=${CATS//\~\//$HOME\/}
      # Replaces *all* ; to :
      CATS=${CATS//;/:}
      # Replace any occurance of $BASE_CATALOG as we don't want them
      # to occur more than once
      # 1. Replace any / -> \/ to hide "/" for BASE_CATALOG and save it to X
      # 2. Remove BASE_CATALOG from the catalog list ($CATS) 
      # 3. Replace double colons (::) with only one
      X=${BASE_CATALOG//\//\\/}
      CATS=${CATS//$X/}
      CATS=${CATS//::/:}
      # shift 
      ;;
    --catalog-verbose=*)
      CATALOG_VERB=${1#--catalog-verbose=}
      # shift
      ;;
    --catalog-verbose)
      # CATALOG_VERB=3
      # shift
      ;;
    -h|--help|-?)
      echo "Help"
      exit 1
      ;;
    -*)
      PARAMS="$PARAMS $1"
      # shift
      ;;
   esac
   shift;
done

echo "Catalogs: $CATS"
echo "Verbosity: $CATALOG_VERB"

echo "After $@"
echo "Parameters left: $PARAMS"
echo "Done."
