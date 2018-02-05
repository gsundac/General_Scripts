#!/usr/bin/ssh-agent bash
##! /bin/bash
SSH='/usr/bin/ssh'
HOSTS_LIST='/home/dropbox/monthly_summary/tmp/hosts_summary.list'
PSSH="/usr/bin/pssh"
PSSH_OPTIONS=' -O PasswordAuthentication=no -O StrictHostKeyChecking=no -P -t20'
INFILE=$1
CMD=$2

ssh-add /root/.ssh/id_zeus_rsa > /dev/null 2>&1
# $PSSH $PSSH_OPTIONS -h $INFILE -I< $CMD | egrep -v  "SUCCESS|FAILURE" | awk -F: '{print $2}'
$PSSH $PSSH_OPTIONS -h $INFILE -I< $CMD | egrep -v  "SUCCESS|FAILURE" | awk -F: '{print $2}'| egrep -v "logout root|WARNING|Value|(c)|mail|SUPERUSER" | grep [a-z]
