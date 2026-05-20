#!/bin/sh
exec >> "/Library/Logs/Getty Script.log" 2>&1

date=`date "+%A %m/%d/%Y"`
echo " "
echo "********** $0" `date "+%A %m/%d/%Y %H:%M:%S"`" **********"

sudo /usr/local/jamf/bin/jamf policy

echo " "
echo "********** $0 Complete" `date "+%A %m/%d/%Y %H:%M:%S"`" **********"
echo " "
exit 0
