#! /bin/bash
MAIN_FILE=$1
SECOND_FILE=$2
cat $MAIN_FILE | grep -v '^$' |
	while read LINE;
		do
		HOST=`echo $LINE | awk -F, '{print $1}'`
		# MATCH=`grep $HOST  $SECOND_FILE`
		MATCH=`grep -w $HOST  $SECOND_FILE`
		echo "$LINE , $MATCH"  
	done
