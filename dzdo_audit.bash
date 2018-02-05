#! /bin/bash

for i in `adquery user  | awk -F: '{print $1}' `;
#for i in `adquery user  | awk -F: '{print $1}' | egrep -v "sundac|gorodet|chui|bodnar|carpend4|kuresh|mcgill|sysmonit|sysdscvr"`;
do
HOSTNAME=`hostname` 
ROOTEQ=`dzinfo -c $i | egrep "root_equivalent| root "| sed 's/*//g'`
if [ -n "$ROOTEQ" ]; then
echo $i , $HOSTNAME , $ROOTEQ
fi
done
