#! /bin/bash
SCP="/usr/bin/scp "
OPTIONS=' -q -o PasswordAuthentication=no -o StrictHostKeyChecking=no '

for i in `ls /home/sundacg/junk/ `;
do
ping -c1 $i > /dev/null 2>&1
	if [ $? = 0 ]; then
	echo "$i ---"
#	printf "$i --- "
	$SCP $OPTIONS /home/sundacg/junk/$i $i:/etc/facter/facts.d/facts.txt
#	echo " "
	else
	echo $i " is not alive"
	fi
done
