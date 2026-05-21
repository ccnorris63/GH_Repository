#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1 

DATE=`date "+%A %m/%d/%Y %H:%M"`
# Last modified July 16, 2019 Chris Norris

echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
ZOOMVER="4.4.55313.0714"

echo "Installing Zoom (version $ZOOMVER)..."
Installer -pkg /private/tmp/"Zoom_$ZOOMVER.pkg" -target /

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0
