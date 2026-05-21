#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1

echo " "
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
if [ -e /Applications/Adobe\ Photoshop\ CC/Adobe\ Photoshop\ CC.app ]
then
    echo "Removing Bridge CC..."
    /Library/Application\ Support/Adobe/Uninstall/\{B42E718A-AAE9-4C7D-8990-2AE4C4FE87DF\}.app/Contents/MacOS/Uninstall\ Product
    echo "Removing Photoshop CC..."
    /Library/Application\ Support/Adobe/Uninstall/\{2D99B50E-431D-4AA8-85C1-172A6F8BCF09\}.app/Contents/MacOS/Uninstall\ Product
else
    echo "Adobe Photoshop CC was NOT found, hence it was not removed."
fi

echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"
exit 0