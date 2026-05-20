#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1 

# Last modified September 29, 2015, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
echo "Running Fiery Software Uninstaller.dmg..."
hdiutil attach -nobrowse /private/tmp/Fiery\ Software\ Uninstaller.dmg
open /Volumes/Fiery\ Software\ Uninstaller/Fiery\ Software\ Uninstaller.app

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0
