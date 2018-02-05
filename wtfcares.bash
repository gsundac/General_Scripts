#! /bin/bash
last | awk '{print $1}' | sort -u | egrep -v "reboot|wtmp"
