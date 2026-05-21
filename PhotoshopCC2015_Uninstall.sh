#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1

echo " "
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
if [ -e /Applications/Adobe\ Photoshop\ CC/Adobe\ Photoshop\ CC\ 2015.app ]
then
    echo "Removing Bridge CC..."
    /Library/Application\ Support/Adobe/Uninstall/\{B42E718A-AAE9-4C7D-8990-2AE4C4FE87DF}.app/Contents/MacOS/Uninstall\ Product
    echo "Removing Photoshop CC 2015..."
    /Library/Application\ Support/Adobe/Uninstall/\{2614BC86-757D-4293-9E25-E4E16F370A9E}.app/Contents/MacOS/Uninstall\ Product
else
    echo "Adobe Photoshop CC 2015 was NOT found, hence it was not removed."
fi

echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"
exit 0