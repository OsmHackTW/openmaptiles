#!/bin/bash

mkdir -p /export/changed-tiles
TILE_LOG=/export/changed-tiles/tiles-$(date +%m%d%H%M)
FILE_LIST=/export/files

find /export -name *.tiles | tee $FILE_LIST | \
xargs cat | sort -u | tee /export/tiles.txt > $TILE_LOG && \
cat $FILE_LIST | xargs rm $FILE_LIST
