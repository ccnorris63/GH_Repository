#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1 

# Last modified May 11, 2018, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
echo "Installing EPSON 10000XL Scanner Driver and Scan Utility v3.4.9.6..."
hdiutil attach -nobrowse /private/tmp/epson15964.dmg
open /Volumes/epson15964_twain_driver_and_epson_scan_utility_3496/EPSON\ Scan.pkg

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0
