#!/bin/bash

FILE_LIST=/export/files

find /export -name *.tiles | \
tee FILE_LIST | \
xargs cat > /export/tiles.txt && \
cat FILE_LIST | xargs rm &&
rm FILE_LIST
