#! /bin/bash
## Script to remove an account from a list of servers.
## To be called as "./del_user.bash $LIST where LIST can be a list of quoted servers i.e. 'server1 server2'
FILE=/home/scadamin/sources/hosts
LIST=$1 # Just to make it easier to figure out what $1 is..
SCP="/usr/bin/scp"
OPTIONS=' -q -p -o PasswordAuthentication=no -o StrictHostKeyChecking=no -o ConnectTimeout=3'
for i in $1;
do
/usr/bin/nc -w 5 -z $i 22 >/dev/null 2>&1
        if [ $? = 0 ]; then
        printf "$i ==> "
	#echo $CMD
        $SCP $OPTIONS  $FILE  $i:/tmp/hosts
        echo
        else echo "$i does not exist"
        fi
done

