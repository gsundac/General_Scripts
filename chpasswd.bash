#! /bin/bash
## Script to reset password for a user across a list of servers.
## To be called as "./chpasswd.bash $USER $PASSWORD $LIST where LIST can be a list of quoted servers i.e. 'server1 server2'
#set -x
# Could use $1 $2 $3, but to make the script a bit more readable I've reassigned the variables.
USER=$1
PASSWD=$2
LIST=$3 
CMD="/home/sundacg/SCRIPTS/chgpasswd.expect"

for i in $LIST;
do
/usr/bin/nc -w 5 -z $i 22 >/dev/null 2>&1
        if [ $? = 0 ]; then
        printf "$i ==> "
	$CMD $USER $PASSWD $i
	echo 
        else 	
	echo "$i does not exist"
        fi
done
