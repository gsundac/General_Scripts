#! /bin/bash
service syslog status > /dev/null 2>&1
        if [ $? = 0 ]; then
        printf "Updating syslog.conf.... "
        sed -i 'authpriv.* /a authpriv.* 	@socevents2.enbridge.com >> /etc/syslog.tmp
	cp /etc/syslog.conf /etc/syslog.jan192018
	cp /etc/syslog.tmp /etc/syslog.conf
	service syslog restart
        fi
done
