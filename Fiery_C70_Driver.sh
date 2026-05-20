#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1 
CocoD="/Applications/Utilities/CocoaDialog.app/Contents/MacOS/CocoaDialog"

# Last modified July 2, 2019, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
echo "Opening Xerox Fiery Driver Installer..."
open /private/tmp/Fiery\ Printer\ Driver_2.0_FD63_V1.pkg
echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0
