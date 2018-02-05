#! /usr/bin/bash
sed -n '/^passwd/p' /etc/nsswitch.conf | grep -i centrify > /dev/null 2>&1
	if [ $? = 0 ]; then
	mv /suit /suit.retired
	fi
