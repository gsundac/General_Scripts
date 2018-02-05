#! /bin/bash
## Script to distribute an account to a list of servers.
## To be called as "./add_user.bash $USER $LIST
SSH="/usr/bin/ssh"
GROUP=$1
GROUP_FILE='/var/yp/MAPS/group'
GID=`grep ^$GROUP $GROUP_FILE | awk -F: '{print $3}'`
OPTIONS=' -q -o PasswordAuthentication=no -o StrictHostKeyChecking=no -o ConnectTimeout=3'
CMD="groupadd -g $GID $GROUP"

for i in $2;
do
/usr/bin/nc -w 5 -z $i 22 >/dev/null 2>&1
        if [ $? = 0 ]; then
        printf "$i ==> "
	echo $CMD
        $SSH $OPTIONS  $i $CMD
        else echo "$i does not exist"
        fi
done
