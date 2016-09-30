#!/bin/csh  -f 

#
# kill duplicated process
# run on HP-UX 11.31
# 


if ($#argv != 2) then
    echo "USAGE : $0 user process"
    exit 1
endif

set PID=`ps -ef | /bin/grep $1 | /bin/grep $2 | awk '{print $2}'`

foreach PID ($PID)
    /usr/bin/kill -9 $PID
    echo KILL -9  $PID
end

exit 0
