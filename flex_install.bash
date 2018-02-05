#! /bin/bash
UNAME=`uname -p`
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

 x86_64) rpm -ivh /var/tmp/managesoft-12.1.0-1.x86_64.rpm ;
         echo "COMPLETE";;
 
 sparc) echo "Do it the old way" ;
         echo "COMPLETE";;

 *)      printf SOMETHINGELSE;;
esac

