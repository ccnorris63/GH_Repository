#!/bin/sh
exec >> "/Library/Logs/OTW_Upgrade.log" 2>&1

# Last modified December 18, 2017, Chris Norris
DATE=`date "+%A %m/%d/%Y %H:%M"`

echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
mkdir -p /Library/CompanyName/Markers
touch /Library/CompanyName/Markers/OTW_HighSierra.txt
echo "This system has been an OTW Upgrade" >> /Library/CompanyName/Markers/OTW_HighSierra.txt
ls -l@ /Library/CompanyName/Markers
echo " "
echo "Backing up the dock, desktop, and desktop.db files..."
cp ~/Library/Application\ Support/Dock/desktoppicture.db ~/Library/Application\ Support/Dock/desktoppicture.db.backup
cp ~/Library/Preferences/com.apple.desktop.plist ~/Library/Preferences/com.apple.desktop.plist.backup
cp ~/Library/Preferences/com.apple.dock.plist ~/Library/Preferences/com.apple.dock.plist.backup

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
