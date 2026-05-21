#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1 

# Last modified February 02, 2017, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
ROBOVER="8.1.2"
echo "Mounting /private/tmp/roboform-mac-v8.dmg..."
hdiutil attach -nobrowse /private/tmp/roboform-mac-v8.dmg
ls -la /Volumes
echo "Copying RoboForm.app to Applications folder..."
cp -rfv /Volumes/roboform-mac-installer/RoboForm.app /Applications

echo "Dismounting /Volumes/roboform-mac-installer..."
umount /Volumes/roboform-mac-installer

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0
