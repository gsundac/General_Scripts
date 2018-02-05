#! /bin/bash
NOOP="yes"
OPSUPPORT="UNIX Server Support"
OOBM="TBD"
ENBALERT="0x0"
ENBCMNT="TBD"
MAIN_FILE=$1
cat $MAIN_FILE | grep -v '^$' |
	while read LINE;
		do
		HOST=`echo $LINE | awk -F, '{print $1}' | sed 's/ //g'`
		ENBINDATE=`echo $LINE | awk -F, '{print $2}'| sed 's/ //g'`
		ENBAPPSUPPORT=`echo $LINE | awk -F, '{print $4}'| sed 's/ //g'`
		ENBSERVICE=`echo $LINE | awk -F, '{print $5}'| sed 's/ //g'`
		ENBSUBSERVICE=`echo $LINE | awk -F, '{print $6}'| sed 's/ //g'`
		ENBPRDSTATUS=`echo $LINE | awk -F, '{print $7}'| sed 's/ //g'`
printf "enbnoop=$NOOP\nenbossupport=$OPSUPPORT\nenbappsupport=$ENBAPPSUPPORT\nenbservice=$ENBSERVICE\nenbsubservice=$ENBSUBSERVICE\nenbindate=$ENBINDATE\nenbstatus=$ENBPRDSTATUS\nenbalerting=$ENBALERT\nenboobmgmt=$OOBM\nenbcomment=$ENBCMNT\n"  > /home/sundacg/junk/$HOST
	done
