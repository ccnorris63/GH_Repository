#!/bin/sh
exec >> "/Library/Logs/Getty Installations.log" 2>&1 

# Last modified September 29, 2015, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
echo "Installing EPSON SP4900 Printer Driver v9.6.5..."
sudo installer -pkg /private/tmp/EPSON\ SP4900\ Printer_v965.pkg -target /

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0
