#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1 

# Last modified February 02, 2017, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
FCHVER="5.7.7"
echo "Mounting /private/tmp/Fetch_$FCHVER.dmg..."
hdiutil attach -nobrowse /private/tmp/Fetch_"$FCHVER".dmg
ls -la /Volumes
echo "Installing in the Applications folder..."
cp -rfv /Volumes/Fetch\ Installer/Fetch.app /Applications
mv -fv /private/tmp/Fetch\ Files/Preferences/com.fetchsoftworks.Fetch.Shortcuts.plist /Library/Preferences
mv -fv /private/tmp/Fetch\ Files/Preferences/com.fetchsoftworks.Fetch.plist /Library/Preferences
mv -fv /private/tmp/Fetch\ Files/com.fetchsoftworks.Fetch /Library
echo "Dismounting /Volumes/Fetch Installer..."
umount /Volumes/Fetch\ Installer

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0
