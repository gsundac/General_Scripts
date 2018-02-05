RESULTS='hosts.csv'
RES_PATH='/net/hs/vol/unix_home/hsmnt/home/dropbox/hosts_summary'
SCRIPTS='/home/sundacg/SCRIPTS/monthly_summary'
HOSTS_LIST='/net/hs/vol/unix_home/hsmnt/home/dropbox/hosts_summary/hosts_summary.list'
DATE=`date +%Y-%m-%d`
/usr/bin/ssh -q algernon '/home/gregorsc/algernon4gord.sh'| grep -v authordate > $HOSTS_LIST

cp $SCRIPTS/getdata.bash /tmp/getdata.bash
$SCRIPTS/filecopy2.bash $HOSTS_LIST /tmp/getdata.bash
$SCRIPTS/run_remote2.bash $HOSTS_LIST 'sh /tmp/getdata.bash' | tee $RES_PATH/$RESULTS
$SCRIPTS/datecalc.bash > $RES_PATH/allhosts-$DATE.csv
$SCRIPTS/genstats2.bash > $RES_PATH/summary-$DATE.csv
# bin/uuencode  $RES_PATH/summary.csv summary.csv | /bin/mailx -s "Monthly Summary" gord.sundac@enbridge.com
# echo " Summary for today is at '\\\\'hs\unix_home$\dropbox\hosts_summary\summary-$DATE.csv.  
# Full monthly summary is at \\\\hs\unix_home$\dropbox\hosts_summary\allhosts-$DATE.csv. " | mailx -s "Monthly Summary" gord.sundac@enbridge.com
