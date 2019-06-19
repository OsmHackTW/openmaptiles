#!/bin/bash
# generate changed tiles and restart updating with OSM diff

# I think this is where docker-compose in
export PATH="/usr/local/bin/:$PATH";

echo PATH= $PATH
make stop-update
make changed-tiles && \
make update-minutely
