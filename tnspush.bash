#! /bin/bash

for i in `cat /net/man-fas-01/vol/unix_home/hsmnt/home/scottk/theTrimList.txt`;
do
ping $i 1 > /dev/null 2>&1
        if [ $? = 0 ]; then
        echo "$i ---"
        scp -o StrictHostKeyChecking=no /tmp/tnsnames.ora $i:"/opt/oracle/product/1020/network/admin/tnsnames.ora"
        scp -o StrictHostKeyChecking=no /tmp/tnsnames.ora $i:"/opt/oracle/product/10.2.0c/network/admin/tnsnames.ora"
        scp -o StrictHostKeyChecking=no /tmp/tnsnames.ora $i:"/opt/oracle/product/8.1.7c/network/admin/tnsnames.ora"
        else
        echo $i " is not alive"
        fi
done

