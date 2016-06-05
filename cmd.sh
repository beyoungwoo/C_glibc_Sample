#!/bin/sh

id_list="user00 user01 user02 user03 user04 user05 user06 user07 user08 user09"
ip="localhost";

if [ "$1" == "-bg" ]; then
    shift
    for id in $id_list; do
        ssh -t $id@$ip "$@" 2>&1 | sed "s/^/[37;1m$id:[0m /" &
    done
else
    for id in $id_list; do
        #ssh $id@$ip $"${@// /\\ }" 2>&1 | sed "s/^/$id: /" &
        ssh -t $id@$ip "$@" 2>&1 | sed "s/^/[37;1m$id:[0m /"
    done
fi

wait
