#!/bin/bash
SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

if [ "$1" == "RECIPE" ]
then
    # RECIPE
    echo "Entering $SCRIPTPATH/../RECIPE"
    cd $SCRIPTPATH/../RECIPE
    git add -A .
    echo "Exporting to the patch: $SCRIPTPATH/RECIPE.diff"
    git diff --cached > ../patches/RECIPE.diff
elif [ "$1" == "memcached" ]
then
    # memcached-pmem
    echo "Entering $SCRIPTPATH/../memcached-pmem"
    cd $SCRIPTPATH/../memcached-pmem
    echo "Exporting to the patch: $SCRIPTPATH/memcached-pmem.diff"
    git diff Makefile.am configure.ac hash.c hash.h items.c memcached.c memcached.h slabs.c > ../patches/memcached-pmem.diff
elif [ "$1" == "CCEH" ]
then
    # CCEH
    echo "Entering $SCRIPTPATH/../CCEH"
    cd $SCRIPTPATH/../CCEH
    echo "Exporting to the patch: $SCRIPTPATH/CCEH.diff"
    git diff > ../patches/CCEH.diff
elif [ "$1" == "FAST_FAIR" ]
then
    # FAST_FAIR
    echo "Entering $SCRIPTPATH/../FAST_FAIR"
    cd $SCRIPTPATH/../FAST_FAIR
    echo "Exporting to the patch: $SCRIPTPATH/FAST_FAIR.diff"
    git diff > ../patches/FAST_FAIR.diff
elif [ "$1" == "clevel" ]
then
    # Clevel-Hashing
    echo "Entering $SCRIPTPATH/../Clevel-Hashing"
    cd $SCRIPTPATH/../Clevel-Hashing
    echo "Exporting to the patch: $SCRIPTPATH/Clevel-Hashing.diff"
    git diff > ../patches/Clevel-Hashing.diff
else
    echo "valid options: RECIPE, memcached, CCEH, FAST_FAIR, clevel"
fi