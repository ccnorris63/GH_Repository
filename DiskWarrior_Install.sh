#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1

echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
echo "Mounting /private/tmp/DiskWarrior5.dmg ..."
hdiutil attach -nobrowse /private/tmp/DiskWarrior5.dmg
ls -la /Volumes

echo "Installing Disk Warrior 5...."
sudo /Volumes/DW/DiskWarrior\ 5\ Installer.app/Contents/MacOS/applet

sleep 5
echo "Dismounting /Volumes/DW ..."
umount -v /Volumes/DW

if (test $? = 0) then
	date '+%A %m/%d/%Y %H:%M:%S  Google Chrome was installed successfully.'
else
	date '+%A %m/%d/%Y %H:%M:%S  Google Chrome installation failed.'
fi
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit $?