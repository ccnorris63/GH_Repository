#!/bin/sh
exec >> "/Library/Logs/OTW_Upgrade.log" 2>&1

# Last modified March 18, 2019, Chris Norris
DATE=`date "+%A %m/%d/%Y %H:%M"`

echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
mkdir -p /Library/Getty/Markers
touch /Library/Getty/Markers/OTW_Mojave.txt
echo "This system has been an OTW Upgrade" >> /Library/Getty/Markers/OTW_Mojave.txt
ls -l@ /Library/Getty/Markers
echo " "

if [ -e /usr/local/jamf/bin/jamf ]
then
    /usr/local/jamf/bin/jamf recon
    sleep 10
elif [ -e /usr/sbin/jamf ]
then
    /usr/sbin/jamf recon
    sleep 10
else
    echo "No JAMF binary found"
fi

echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"
