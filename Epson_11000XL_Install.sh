#!/bin/sh
exec >> "/Library/Logs/Getty Installations.log" 2>&1 

# Last modified April 03, 2018, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
echo "Installing EPSON 11000XL Scanner Driver and Scan Utility v3.4.9.10..."
sudo installer -pkg /private/tmp/EPSON\ ScanX_v3.4.9.10.pkg -target /

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0
