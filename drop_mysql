#!/bin/bash
#ident "@(#)create_user v1.0 14/08/11 o"
#Tested RedHat 5.4
 
EXPECTED_ARGS=3
E_BADARGS=65
MYSQL=`which mysql`
 
Q1="DROP USER '$1'@'localhost';"
Q2="DROP DATABASE $2;"
SQL="${Q1}${Q2}"
 
if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: $0 db_user db_name"
  exit $E_BADARGS
fi
 
$MYSQL -uroot -p$3 -e "$SQL"
