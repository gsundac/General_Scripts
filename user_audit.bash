#! /bin/bash

HOSTNAME=`hostname` 
if [ ! -f /usr/bin/adinfo ]; 
then
	echo $HOSTNAME,"No User Info,""This system does not use central accounts management"
else
	for i in `adquery user  | awk -F: '{print $1}' `;
	do
	ROOTEQ=`dzinfo -c $i | egrep "root_equiv| root " `
		if [ -n "$ROOTEQ" ]; then
#		echo $HOSTNAME,$i,\""$ROOTEQ"\"
		echo $HOSTNAME,$i,"$ROOTEQ"
		fi
	done
fi
