#! /bin/bash
UNAME=`uname`
HOSTNAME=`hostname| awk -F"." '{print $1}'`
OUTFILE='/var/tmp/luns.out'
DATE=`date +%Y-%m-%d`

case "$UNAME" in

 HP-UX) CMD=`ioscan -m lun -d esdisk > $OUTFILE.$DATE`;
	NUM_DEVICES=`cat $OUTFILE.$DATE | wc -l`;
	NUM_ONLINE=`cat $OUTFILE.$DATE | grep online | wc -l`;
        printf "HOSTNAME=$HOSTNAME -- DEVICES=$NUM_DEVICES -- ONLINE=$NUM_ONLINE";;

 Linux)	CMD=`multipath -ll > $OUTFILE.$DATE`; 
	NUM_DEVICES=`cat $OUTFILE.$DATE | wc -l` ; 
	NUM_ONLINE=`cat $OUTFILE.$DATE | grep active | wc -l`;
        printf "HOSTNAME=$HOSTNAME -- DEVICES=$NUM_DEVICES -- ONLINE=$NUM_ONLINE";;

 *)      printf SOMETHINGELSE;;
esac

