#!/bin/sh
exec >> "/Library/Logs/CompanyName Script.log" 2>&1

date=`date "+%A %m/%d/%Y"`
echo " "
echo "********** $0" `date "+%A %m/%d/%Y %H:%M:%S"`" **********"
echo "Turn OFF hibernate mode"
pmset -c hibernatemode 0
echo "Disable sleep"
pmset -c sleep 0
echo "Disable disksleep"
pmset -c disksleep 0
echo "Turn OFF Darkwakes mode"
pmset -c darkwakes 0
echo "Set Display Sleep to 30 mins."
pmset -c displaysleep 30

echo "********** $0 Complete" `date "+%A %m/%d/%Y %H:%M:%S"`" **********"
echo " "
exit 0