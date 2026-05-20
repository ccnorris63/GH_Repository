#!/bin/sh
exec >> "/Library/Logs/Getty Installations.log" 2>&1 

# Last modified MAy 21, 2019, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "

SUPDUPVER="3.2.4"

echo "Mounting SuperDuper!-$SUPDUPVER.dmg and accepting EULA..."
yes qy | hdiutil attach -nobrowse "/private/tmp/SuperDuper!-$SUPDUPVER.dmg"

ls -la /Volumes

echo "Installing in the Applications folder..."
cp -rfv /Volumes/SuperDuper\!/SuperDuper\!.app /Applications
umount /Volumes/SuperDuper\!

for USER_HOME in /Users/*
  do
    USER_UID=`basename "${USER_HOME}"`
    if [ ! "${USER_UID}" = "Shared" ] 
    then 
    	cp -rfv /private/tmp/SuperDuper_Lic/SuperDuper! /Users/"${USER_UID}"/Library/Application\ Support
    	cp -fv /private/tmp/SuperDuper_Lic/com.blacey.SuperDuper!.plist /Users/"${USER_UID}"/Library/Preferences
    	chown -R "${USER_UID}" /Users/"${USER_UID}"/Library/Application\ Support/SuperDuper!
    	chown "${USER_UID}" /Users/"${USER_UID}"/Library/Preferences/com.blacey.SuperDuper!.plist
	fi
  done

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0
