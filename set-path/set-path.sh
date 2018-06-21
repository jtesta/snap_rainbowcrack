#!/bin/bash

# Setting LD_LIBRARY_PATH doesn't work, since the binaries explicitly open this
# library from the local directory.
if [ ! -f $SNAP_USER_COMMON/alglib0.so ]; then
  cp $SNAP/alglib0.so $SNAP_USER_COMMON
fi

if [ ! -f $SNAP_USER_COMMON/charset.txt ]; then
  cp $SNAP/charset.txt $SNAP_USER_COMMON
fi

pushd $SNAP_USER_COMMON > /dev/null
echo "Setting working directory to: $PWD..."
CMD=$SNAP/$1
shift # Remove the first element in the $@ array, since that has the $1 arg.
exec $CMD "$@"
popd > /dev/null
