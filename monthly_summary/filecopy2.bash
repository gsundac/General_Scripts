#! /bin/bash
PSCP="/usr/bin/pscp.pssh"
PSCP_OPTIONS=' -O PasswordAuthentication=no -O StrictHostKeyChecking=no -t10 '
INPUT=`cat /net/hs/vol/unix_home/hsmnt/home/dropbox/hosts_summary/hosts_summary.list | awk '{print $1}' > /tmp/junk`
INFILE='/tmp/junk'
SOURCE_FILE='/home/sundacg/SCRIPTS/monthly_summary/getdata.bash'
DEST_FILE='/tmp/getdata.bash'
DATE=`date +%Y-%m-%d_%T`
ERROR_LOG="/home/dropbox/monthly_summary/logs/pscp.errors.$DATE"
$PSCP $PSCP_OPTIONS -h $INFILE $SOURCE_FILE $DEST_FILE | grep FAILURE > $ERROR_LOG
