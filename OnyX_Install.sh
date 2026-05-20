#!/bin/sh
exec >> "/Library/Logs/Getty Installations.log" 2>&1

echo " "
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "

DATE=`date "+%A %m/%d/%Y %H:%M"`
OSver=`sw_vers -productVersion`
OSpatch=`sw_vers -productVersion | awk -F . '{print $2}'`
ONYX11="3.1.9"
ONYX12="3.3.1"
ONYX13="3.4.9"
ONYX14="3.6.0"

rm -rfv /Applications/Utilities/OnyX.app

if [[ "$OSpatch" == 11 ]];then
	echo "Mounting OnyX_$ONYX11(10.11).dmg..."
	yes "y" | hdiutil attach -nobrowse /private/tmp/"OnyX_$ONYX11(10.11)".dmg
	echo " "
	echo "Installing OnyX_$ONYX11 for El Capitan..."
	sudo cp -rf /Volumes/"OnyX $ONYX11"/OnyX.app /Applications/Utilities
	sleep 5
	echo "Unmounting OnyX_$ONYX11 Installer..."
	sudo umount -vf /Volumes/"OnyX $ONYX11"
fi
if [[ "$OSpatch" == 12 ]];then
	echo "Mounting OnyX_$ONYX12(10.12).dmg..."
	yes "y" | hdiutil attach -nobrowse /private/tmp/"OnyX_$ONYX12(10.12)".dmg
	echo " "
	echo "Installing OnyX_$ONYX12 for Sierra..."
	sudo cp -rf /Volumes/"OnyX $ONYX12"/OnyX.app /Applications/Utilities
	sleep 5
	echo "Unmounting OnyX_$ONYX12 Installer..."
	sudo umount -vf /Volumes/"OnyX $ONYX12"
fi
if [[ "$OSpatch" == 13 ]];then
	echo "Mounting OnyX_$ONYX13(10.13).dmg..."
	yes "y" | hdiutil attach -nobrowse /private/tmp/"OnyX_$ONYX13(10.13)".dmg
	echo " "
	echo "Installing OnyX_$ONYX13 for High Sierra..."
	sudo cp -rf /Volumes/"OnyX $ONYX13"/OnyX.app /Applications/Utilities
	sleep 5
	echo "Unmounting OnyX_$ONYX13 Installer..."
	sudo umount -vf /Volumes/"OnyX $ONYX13"
fi
if [[ "$OSpatch" == 14 ]];then
	echo "Mounting OnyX_$ONYX14(10.14).dmg..."
	yes "y" | hdiutil attach -nobrowse /private/tmp/"OnyX_$ONYX14(10.14)".dmg
	echo " "
	echo "Installing OnyX_$ONYX14 for High Sierra..."
	sudo cp -rf /Volumes/"OnyX $ONYX14"/OnyX.app /Applications/Utilities
	sleep 5
	echo "Unmounting OnyX_$ONYX14 Installer..."
	sudo umount -vf /Volumes/"OnyX $ONYX14"
fi

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "

exit 0