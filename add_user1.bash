#! /bin/bash
## Script to distribute an account to a list of servers.
## To be called as "./add_user.bash $USER $LIST where LIST can be a list of quoted servers i.e. 'server1 server2'
TEMPLATE=/home/sundacg/SCRIPTS/add_user_allOS.template
TMP_SCRIPT=/tmp/add_user.tmp
USER=$1
PASSWD_FILE="/var/yp/MAPS/passwd"
SHAD_FILE="/var/yp/MAPS/shadow"
SSH="/usr/bin/ssh"
USERNAME=`grep ^$USER: $PASSWD_FILE | awk -F: '{print $1}'`
USID=`grep ^$USER: $PASSWD_FILE | awk -F: '{print $3}'`
GID=`grep ^$USER: $PASSWD_FILE | awk -F: '{print $4}'`
GCCOS=`grep ^$USER: $PASSWD_FILE | awk -F: '{print $5}'`
SHELL=`grep ^$USER: $PASSWD_FILE | awk -F: '{print $7}'`
PASSWD=`grep ^$USER: $SHAD_FILE | awk -F: '{print $2}'`
PSSH="/usr/bin/pssh"
PSSH_OPTIONS=' -O PasswordAuthentication=no -O StrictHostKeyChecking=no -P -t20'
OPTIONS=' -q -o PasswordAuthentication=no -o StrictHostKeyChecking=no -o ConnectTimeout=3'

## Moving any spaces out of the gccos field, because I ain't smart enough to deal with them...
GC_COS=`echo $GCCOS | sed 's/ /_/g' `
##CMD="/home/sundacg/SCRIPTS/add_user_allOS.bash $USID $GID $GC_COS $PASSWD $SHELL $USERNAME"
# Write a new script that can be passed through ssh or pssh that has all the variables defined
sed "/MARKER/a\ \t"USERNAME=$USERNAME"\n\tUSID=$USID\n\tGID=$GID\n\tGC_COS=$GC_COS\n\tSHELL=$SHELL\n\tPASSWD=$PASSWD" $TEMPLATE > $TMP_SCRIPT
#sed '/MARKER/a\ USERNAME=$USERNAME;USID=$USID;GID=$GID;GC_COS=$GC_COS;SHELL=$SHELL;PASSWD=$PASSWD' $TEMPLATE > $TMP_SCRIPT
##sed "/MARKER/a\ USERNAME=sundacg;USID=$USID;GID=$GID;GC_COS=$GC_COS;SHELL=$SHELL;PASSWD=$PASSWD" $TEMPLATE > $TMP_SCRIPT


for i in $2;
do
/usr/bin/nc -w 5 -z $i 22 >/dev/null 2>&1
        if [ $? = 0 ]; then
        printf "$i ==> "
#	 $SSH $OPTIONS  $i 'echo oracle >> /etc/centrifydc/user.ignore'
#	sleep 2
        $SSH $OPTIONS  $i 'bash -s' < $TMP_SCRIPT
        #$SSH $OPTIONS  $i < $TMP_SCRIPT
        #$PSSH $POPTIONS -H $i -I< $TMP_SCRIPT
        echo
        else echo "$i does not exist"
        fi
done
