#! /bin/bash
PSSH="/usr/bin/pssh"
#PSSH_OPTIONS=' -O PasswordAuthentication=no -O StrictHostKeyChecking=no -P -t10'
PSSH_OPTIONS=' --inline-stdout -O PasswordAuthentication=no -O StrictHostKeyChecking=no -P -t10'
#INFILE="/net/hs/vol/unix_home/hsmnt/home/dropbox/hosts_summary/hosts_summary.list"
INPUT=`cat /net/hs/vol/unix_home/hsmnt/home/dropbox/hosts_summary/hosts_summary.list | awk '{print $1}' > /tmp/junk`
INFILE='/tmp/junk'
CMD='sh /tmp/getdata.bash'

$PSSH $PSSH_OPTIONS -h $INFILE $CMD | egrep -v  "SUCCESS|FAILURE"

