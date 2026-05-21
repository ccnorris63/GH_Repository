#!/bin/bash

exec >> "/Library/Logs/CompanyName Script.log" 2>&1

echo " "
echo "********** $0" `date "+%A %m/%d/%Y %H:%M:%S"`" **********"
echo " "

if [ -e /Library/Application\ Support/JAMF/Waiting\ Room/Office2016_15250Upd.dmg ]
    then
        echo "Removing Old Office Cache 15250"
        rm -rf /Library/Application\ Support/JAMF/Waiting\ Room/Office2016_15250Upd.dmg
        rm /Library/Application\ Support/JAMF/Waiting\ Room/Office2016_15250Upd.dmg.cache.xml
fi

if [ -e /Library/Application\ Support/JAMF/Waiting\ Room/Office2016_15260Upd.dmg ]
    then
        echo "Removing Old Office Cache 15260"
        rm -rf /Library/Application\ Support/JAMF/Waiting\ Room/Office2016_15260Upd.dmg
        rm /Library/Application\ Support/JAMF/Waiting\ Room/Office2016_15260Upd.dmg.cache.xml
fi

if [ -e /Library/Application\ Support/JAMF/Waiting\ Room/Office2016_15270Upd.dmg ]
    then
        echo "Removing Old Office Cache 15270"
        rm -rf /Library/Application\ Support/JAMF/Waiting\ Room/Office2016_15270Upd.dmg
        rm /Library/Application\ Support/JAMF/Waiting\ Room/Office2016_15270Upd.dmg.cache.xml
fi

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0