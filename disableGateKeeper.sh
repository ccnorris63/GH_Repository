#!/bin/sh
exec >> "/Library/Logs/Getty Script.log" 2>&1

# Last modified February 23, 2017, Chris Norris
DATE=`date "+%A %m/%d/%Y %H:%M"`
echo " "
echo "********** $0 " `date "+%A %m/%d/%Y %H:%M:%S"` " **********" 

echo "Set the Gatekeeper to allow applications downloaded from anywhere..."

/usr/sbin/spctl --master-disable

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M:%S"` " **********"