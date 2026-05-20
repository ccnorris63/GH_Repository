#!/bin/sh
exec >> "/Library/Logs/Getty Installations.log" 2>&1 

# Last modified March 07, 2017, Chris Norris
date=`date "+%A %m/%d/%Y"`
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"

# hdiutil mount -nobrowse /private/tmp/epsonSC-P800.dmg

echo "Installing EPSON SC P800 Printer Driver"
installer -pkg /private/tmp/EpsonSCP800/EPSON\ Printer.pkg -target /
# echo "Opening EPSON application..."
# open /Volumes/SC-P800/EPSON.app
echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0
