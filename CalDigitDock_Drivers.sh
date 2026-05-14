#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1

DATE=`date "+%A %m/%d/%Y %H:%M"`
# Last updated July 26, 2017 Chris Norris
echo " "
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "

if [[ -e /private/tmp/CalDigit\ Docking\ Station\ Utility\ v1.9.01.pkg ]];then
	echo "Installing CalDigit Docking Station Utility v1.9.01..."
	installer -pkg /private/tmp/CalDigit\ Docking\ Station\ Utility\ v1.9.01.pkg -target /
	sleep 5
else
    echo "The CalDigit Docking Station Utility v1.9.01 installer was not found."
fi
if [[ -e /private/tmp/CalDigit\ Thunderbolt\ Station\ Charging\ Support.pkg ]];then
	echo "Installing CalDigit Thunderbolt Station Charging Support..."
	installer -pkg /private/tmp/CalDigit\ Thunderbolt\ Station\ Charging\ Support.pkg -target /
	sleep 5
else
    echo "The CalDigit Thunderbolt Station Charging Support installer was not found."
fi
sudo chmod -R 755 /Applications/CalDigit\ Docking\ Station\ Utility
sudo chmod -R 775 /Applications/CalDigit\ Docking\ Station\ Utility/CalDigit_Docking_Station_Utility.app
open /Applications/CalDigit\ Docking\ Station\ Utility/CalDigit_Docking_Station_Utility.app

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0