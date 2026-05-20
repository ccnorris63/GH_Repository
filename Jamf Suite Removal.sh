#!/bin/sh
exec >> "/Library/Logs/Getty Installations.log" 2>&1 

echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
rm -rfv /Applications/Jamf\ Pro*
rm -rfv /Applications/Utilities/Recon.app
echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0