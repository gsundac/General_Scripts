#! /bin/bash
HOSTNAME=`hostname| awk -F"." '{print $1}'`

NUM=`ps -ef | grep -i oracle | grep -v grep|wc -l `
printf "HOSTNAME=$HOSTNAME -- Oracle_Procs=$NUM"
