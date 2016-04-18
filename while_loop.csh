#!/bin/csh -f

if ($#argv != 1) then
    echo "give exactily 1 parameter" 
    echo "USAGE : $0 10";
    exit 1;
else 
    set max_num = $argv[1]
endif

@ i = 1

while ($i <= $max_num)
    echo "$i";
    @ i = $i + 1
end
