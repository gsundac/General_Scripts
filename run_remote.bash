#!/usr/bin/ssh-agent bash
##! /bin/bash
# This script is used to serially run commands across a list of systems.
# If you want to run commands in parallel across a large number of systems use run_remote.pssh
# Pre-req is that you have your ssh keys in place prior to running this script.
# Execute the script using a list as the first argument, and the quoted command as the second argument.
# Examole - ./run_remote.bash /tmp/list 'service oracle stop; wall "STOPPING ORACLE" ' 
SSH="/usr/bin/ssh"

OPTIONS=' -q -o PasswordAuthentication=no -o StrictHostKeyChecking=no -o ConnectTimeout=3'
# OPTIONS=' -q '
ssh-add /root/.ssh/id_zeus_rsa > /dev/null 2>&1
ssh-add /root/.ssh/id_rsa_pesu0100 > /dev/null 2>&1
ssh-add -l
for i in `cat $1`;
do
/bin/nc -w 5 -z $i 22 >/dev/null 2>&1
#ping $i -c1 >/dev/null 2>&1
        if [ $? = 0 ]; then
        printf "$i ==> "
#        echo "$i ==> "
        $SSH $OPTIONS  $i "$2"
echo
        else echo "$i does not exist"
        fi
done
