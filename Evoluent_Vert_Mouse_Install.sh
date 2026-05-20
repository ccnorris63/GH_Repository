#!/bin/sh
exec >> "/Library/Logs/Getty Installations.log" 2>&1 

# Last modified August 27, 2015, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "

echo "Mounting EvoluentVerticalMouseDeviceController1.2.0f1.dmg..."
hdiutil attach -nobrowse "/private/tmp/EvoluentVerticalMouseDeviceController1.2.0f1.dmg"

ls -la /Volumes

echo "Installing Evoluent VerticalMouse Device Controller..."
installer -pkg /Volumes/Evoluent\ VerticalMouse\ Device\ Controller/Evoluent\ VerticalMouse\ Device\ Controller.pkg -target /
sleep 3
umount /Volumes/Evoluent\ VerticalMouse\ Device\ Controller

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0
