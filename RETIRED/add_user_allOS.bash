#! /bin/bash
set -x
## Wrapper script to determine OS type and send the right command to add users.
## To be called by "./add_user.bash 
# ------
LINUX_CMD="useradd -u $1 -g $2 -m -c $3 -p $4 -k /etc/skel -s $5 -d /home/$6 $6"
NLINUX_CMD="useradd -u $1 -g $2 -m -c $3 -s $5 -k /etc/skel -d /home/$6 $6"
UNAME=`uname`

## Figure out auth mechanism and if auth is centrify, don't add users.
if [ -f "/etc/nsswitch.conf" ]; then
	sed -n '/^passwd/p' /etc/nsswitch.conf | grep -i Centrify > /dev/null 2>&1
              if [ $? = 0 ]; then
              AUTH=Centrify
		echo "This server is managed by Centrify.  Users should be added through Active Directory.  Exiting with out adding any accounts!!"
		exit
	      fi
else
	AUTH=Files
	echo "Adding user to server..."
fi

case "$UNAME" in

 HP-UX)
	`$NLINUX_CMD`;;

 Linux)
	`$LINUX_CMD`;;

 SunOS)
	`NLINUX_CMD`;;

 *) 
	printf "Can't determine OS Type - Quitting!!";;
esac
