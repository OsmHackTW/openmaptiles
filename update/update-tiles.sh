#!/bin/bash
# generate changed tiles and restart updating with OSM diff

# I think this is where docker-compose in
export PATH="/usr/local/bin/:$PATH";

echo PATH= $PATH
make pause-update changed-tiles >> update/log 2>&1
make resume-update
