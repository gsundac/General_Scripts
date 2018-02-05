#! /bin/bash
## Script to distribute an account to a list of servers.
## To be called as "./set_user_passwd.bash $USER $LIST
USER=$1
SHAD_FILE="/var/yp/MAPS/shadow"
SSH="/usr/bin/ssh"
PASSWD=$3
# PASSWD=`grep ^$USER $SHAD_FILE | awk -F: '{print $2}'`
OPTIONS=' -q -o PasswordAuthentication=no -o StrictHostKeyChecking=no -o ConnectTimeout=3'
CMD='echo \"$PASSWD $PASSWD\" | passwd $USER'
# COMMAND=`echo
# ssh $i "'echo \"$HASH $HASH\" | passwd'"`

for i in $2;
do
/usr/bin/nc -w 5 -z $i 22 >/dev/null 2>&1
        if [ $? = 0 ]; then
        printf "$i ==> "
        $SSH $OPTIONS  $i $CMD
        echo
        else echo "$i does not exist"
        fi
done
