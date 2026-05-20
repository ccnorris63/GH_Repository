#!/bin/sh
exec >> "/Library/Logs/Getty Installations.log" 2>&1 

# Last modified October 03, 2018, Chris Norris
date=`date "+%A %m/%d/%Y"`
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"

hdiutil mount -nobrowse /private/tmp/SCP9000_STD_Combo_64_AM.dmg

echo "Opening EPSON application..."
open /Volumes/SC-P9000/EPSON.app
echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0
