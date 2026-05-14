#!/bin/sh

exec >> "/Library/Logs/CompanyName Script.log" 2>&1

echo " "
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "

launchctl unload /Library/LaunchDaemons/com.crashplan.engine.plist

#launchctl unload $3/Library/LaunchAgents/com.crashplan.engine.plist

rm -rf /Library/Caches/CrashPlan

sleep 30

launchctl load /Library/LaunchDaemons/com.crashplan.engine.plist

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0