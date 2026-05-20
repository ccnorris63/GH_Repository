#!/bin/sh
exec >> "/Library/Logs/Getty Installations.log" 2>&1 

# Last modified March 21, 2019, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
echo "Installing Xerox Printer Drivers v.4.22.2 from Xerox..."
installer -pkg /private/tmp/Xerox\ Print\ Driver\ 4.22.2.pkg -target /
sleep 5
echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0
