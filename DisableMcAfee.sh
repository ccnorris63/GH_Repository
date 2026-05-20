#!/bin/sh
exec >> "/Library/Logs/CompanyName Script.log" 2>&1

echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "

osvers=$(sw_vers -productVersion | awk -F. '{print $2}')

# Checks if the Mac is running 10.10 or higher.
# If so, it runs the launchctl statement needed from Yosemite
# as SystemStarter was removed.

#if [[ ${osvers} -ge 10 ]]
#then
#    launchctl unload /Library/LaunchDaemons/com.mcafee.agent.ma.plist
#else
#    echo "stopping McAfee Agent..."
#    SystemStarter stop cma
#fi

echo "stopping McAfee AntiVirus..."
sudo /usr/local/McAfee/AntiMalware/VSControl stopoas
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"
exit 0