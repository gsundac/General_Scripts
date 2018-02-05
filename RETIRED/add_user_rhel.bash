#! /bin/bash
## Script to distribute an account to a list of servers.
## To be called as "./add_user.bash $USER $LIST
USER=$1
PASSWD_FILE="/var/yp/MAPS/passwd"
SHAD_FILE="/var/yp/MAPS/shadow"
SSH="/usr/bin/ssh"
USERNAME=`grep ^$USER $PASSWD_FILE | awk -F: '{print $1}'`
USID=`grep ^$USER $PASSWD_FILE | awk -F: '{print $3}'`
GID=`grep ^$USER $PASSWD_FILE | awk -F: '{print $4}'`
GCCOS=`grep ^$USER $PASSWD_FILE | awk -F: '{print $5}'`
## Moving any spaces out of the gccos field, because I ain't smart enough to deal with them...
GC_COS=`echo $GCCOS | sed 's/ /_/' `
SHELL=`grep ^$USER $PASSWD_FILE | awk -F: '{print $7}'`
PASSWD=`grep ^$USER $SHAD_FILE | awk -F: '{print $2}'`
OPTIONS=' -q -o PasswordAuthentication=no -o StrictHostKeyChecking=no -o ConnectTimeout=3'
CMD="useradd -u $USID -g $GID -m -c $GC_COS -p $PASSWD -s $SHELL -k /etc/skel -d /home/$USERNAME $USERNAME"

for i in $2;
do
/usr/bin/nc -w 5 -z $i 22 >/dev/null 2>&1
        if [ $? = 0 ]; then
        printf "$i ==> "
	echo $CMD
        ##$SSH $OPTIONS  $i 'bash -s' < $CMD
        $SSH $OPTIONS  $i $CMD
        else echo "$i does not exist"
        fi
done
