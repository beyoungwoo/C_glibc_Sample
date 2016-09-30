#!/bin/bash

#
# Find /etc/services port use daemon count and dump
#

OUT=$HOME/dump_service_port_daemon
INPUT="/etc/services"

if [ -f $INPUT ];
then
    awk '{print $1}' $INPUT | sort -n |uniq -c | sort -n > $OUT
else
    echo "error"
fi

