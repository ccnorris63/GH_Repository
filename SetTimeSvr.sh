#!/bin/sh
exec >> "/Library/Logs/Getty Script.log" 2>&1

date=`date "+%A %m/%d/%Y"`
echo " "
echo "********** $0" `date "+%A %m/%d/%Y %H:%M:%S"`" **********"

if [ ! -e "/etc/ntp.conf" ]; then
	touch /etc/ntp.conf
fi
echo "Setting Network Time, Time zone, and Time Server..."
systemsetup -setusingnetworktime on
systemsetup -settimezone America/Los_Angeles
systemsetup -setnetworktimeserver time.getty.edu

echo " "
echo "********** $0 Complete" `date "+%A %m/%d/%Y %H:%M:%S"`" **********"
echo " "
exit 0
