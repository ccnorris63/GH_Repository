#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1 
# Last modified Dec 09, 2015, Chris Norris
date=`date "+%A %m/%d/%Y"`
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"

hdiutil mount -nobrowse /private/tmp/Code42CrashPlan_Mac.dmg
installer -pkg /Volumes/Code42CrashPlan/Install\ Code42\ CrashPlan.pkg -target /
umount /Volumes/Code42CrashPlan

echo "********** $0 Complete" `date "+%A %m/%d/%Y %H:%M"`" **********"