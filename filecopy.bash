#! /bin/bash
SCP="/usr/bin/scp "
OPTIONS=' -q -o PasswordAuthentication=no -o StrictHostKeyChecking=no '

for i in `cat $1| grep -v largs`;
do
# ping -c1 $i > /dev/null 2>&1
/usr/bin/nc -w 5 -z $i 22 >/dev/null 2>&1
	if [ $? = 0 ]; then
	echo "$i ---"
#	printf "$i --- "
	$SCP $OPTIONS $2 $i:"$2" > /dev/null 2>&1
#	echo " "
	else
	echo $i " is not alive"
	fi
done
