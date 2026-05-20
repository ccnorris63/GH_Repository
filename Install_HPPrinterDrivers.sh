#!/bin/sh
exec >> "/Library/Logs/Getty Installations.log" 2>&1 

# Last modified April 19, 2018, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
echo "Installing HP Printer Drivers v.5.1 from Apple..."
installer -pkg /private/tmp/HewlettPackardPrinterDrivers.pkg -target /
sleep 5
echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0
