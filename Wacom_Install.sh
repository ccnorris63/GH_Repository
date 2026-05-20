#!/bin/sh
exec >> "/Library/Logs/Getty Installations.log" 2>&1 

# Last modified August 09, 2018, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
WCMVER="6.3.30-2"
echo "Mounting /private/tmp/WacomTablet_$WCMVER.dmg..."
hdiutil attach -nobrowse /private/tmp/"WacomTablet_$WCMVER.dmg"

echo "Installing /private/tmp/Install Wacom Tablet.pkg..."
installer -pkg /Volumes/WacomTablet/Install\ Wacom\ Tablet.pkg -target /

echo "Dismounting /Volumes/WacomTablet..."
umount /Volumes/WacomTablet
echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0
