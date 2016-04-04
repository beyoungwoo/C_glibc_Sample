#!/bin/sh
# LINUX only

expected_args=2
E_BADARGS=65

if [ $# -ne $expected_args ]
then
    echo "Usage: $0 pid sleep_sec"
    exit $E_BADARGS
fi

pageSize=$(getconf PAGE_SIZE)

printf "VMSize(KB)\tReserved(KB)\tShared(KB)\tCode\tLibrary\tData/Stack\tDirty\n"

while [ 2 > 1 ]
do

vals=`cat /proc/$1/statm`

totalVM=`echo $vals $pageSize | awk '{print $1*$8/1024}'`
reserved=`echo $vals $pageSize | awk '{print $2*$8/1024}'`
shared=`echo $vals $pageSize | awk '{print $3*$8/1024}'`
code=`echo $vals $pageSize | awk '{print $4*$8/1024}'`
datastack=`echo $vals $pageSize | awk '{print $5*$8/1024}'`
library=`echo $vals $pageSize | awk '{print $6*$8/1024}'`
dirty=`echo $vals $pageSize | awk '{print $7*$8/1024}'`


printf "$totalVM\t\t$reserved\t\t$shared\t\t$code\t$datastack\t$library\t\t$dirty\n"

sleep $2
done
