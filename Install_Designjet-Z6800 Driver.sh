#!/bin/sh
exec >> "/Library/Logs/Getty Installations.log" 2>&1 

# Last modified September 20, 2016, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
echo "Installing HP Designjet Z6800 Plotter Driver..."
installer -pkg /private/tmp/HP\ DesignJet\ PostScript\ Driver.pkg -target /
sleep 5
echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0
