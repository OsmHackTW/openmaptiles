#!/bin/bash

stateFile="data/last.state.txt"

# 2019-06-04T13\:22\:03Z -> 1559622123
timeString=$(head -1 $stateFile | tr -d 'timestamp=\\')
timestamp=$(date -d "$timeString" +%s)

sequenceNumber=$(update/sequence_number.sh $1 $timestamp)
sed -i "2s/.*/sequenceNumber=$sequenceNumber/g" $stateFile
