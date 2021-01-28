#!/bin/bash
SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

reset_and_apply() {
    echo "Processing $1"
    echo "Entering $SCRIPTPATH/../$1"
    cd $SCRIPTPATH/../$1
    echo "Resetting the working directory"
    git reset --hard
    git clean -xfd
    echo "Applying the patch: $SCRIPTPATH/$1.diff"
    git apply ../patches/$1.diff
}

if [ "$1" == "RECIPE" ]
then
    # RECIPE
    reset_and_apply "RECIPE"
elif [ "$1" == "memcached" ]
then
    # memcached-pmem
    reset_and_apply "memcached-pmem"
elif [ "$1" == "CCEH" ]
then
    # CCEH
    reset_and_apply "CCEH"
elif [ "$1" == "FAST_FAIR" ]
then
    # FAST_FAIR
    reset_and_apply "FAST_FAIR"
elif [ "$1" == "clevel" ]
then
    # Clevel-Hashing
    reset_and_apply "Clevel-Hashing"
else
    echo "valid options: RECIPE, memcached, CCEH, FAST_FAIR, clevel"
fi