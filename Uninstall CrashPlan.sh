#!/bin/sh

exec >> "/Library/Logs/Getty Script.log" 2>&1

echo " "
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "


sudo -u $(ls -l /dev/console | awk '{print $3}') open /Library/Application\ Support/CrashPlan/Uninstall.app

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0