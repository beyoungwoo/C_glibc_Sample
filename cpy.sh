#!/bin/sh

id_list="user_id01 user_id02 user_id03 user_id04 user_id05 user_id06 user_id07 user_id08 user_id09"

ip="localhost"

if [ 2 -gt "$#" ]; then
    echo "Usage: $0 \"<local full path> <remote full path>\""
    exit 1
fi

for id in $id_list
do
    scp "$1" $id@@$ip:"$2"
done
