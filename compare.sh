#! /usr/bin/bash
#sed -n '/^passwd/p' /etc/nsswitch.conf | grep -i centrify > /dev/null 2>&1
#	if [ $? = 0 ]; then
#	mv /suit /suit.retired
#	fi

cat /tmp/list | while read LINE;
do 
grep $LINE /home/dropbox/monthly_summary/outputs/allhosts.csv
if [ $? = 0 ]; then
echo $LINE in
else
echo $LINE out
fi
done
# done > /home/dropbox/monthly_summary/outputs/diff.csv
