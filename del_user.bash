#! /bin/bash
## Script to remove an account from a list of servers.
## To be called as "./del_user.bash $USER $LIST where LIST can be a list of quoted servers i.e. 'server1 server2'
USER=$1
LIST=$2 # Just to make it easier to figure out what $2 is..
SSH="/usr/bin/ssh"
OPTIONS=' -q -o PasswordAuthentication=no -o StrictHostKeyChecking=no -o ConnectTimeout=3'
CMD="/usr/sbin/userdel -r $USER"
for i in $2;
do
/usr/bin/nc -w 5 -z $i 22 >/dev/null 2>&1
        if [ $? = 0 ]; then
        printf "$i ==> "
	#echo $CMD
        $SSH $OPTIONS  $i $CMD 
        echo
        else echo "$i does not exist"
        fi
done

