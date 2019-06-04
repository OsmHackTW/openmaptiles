#!/bin/bash

case $1 in
    # hour difference with Tue Jun  4 03:00:00 CST 2019
    # sequence number=58940
    --hour)
    echo $[($2 - 1559617200)/3600 + 58940]
    ;;
    # minute difference with Tue Jun  4 03:00:02 CST 2019
    # sequence number=3523980
    --minute)
    echo $[($2 - 1559617202)/60 + 3523980]
esac
