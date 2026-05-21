#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1 

echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
if [ -e /Applications/McAfee\ Endpoint\ Security\ for\ Mac.app ] 
then
	echo "McAfee Endpoint Security for Mac found in the Application folder, uninstalling..."
	/usr/local/McAfee/uninstall EPM
else
	echo "No McAfee Endpoint Security for Mac found in the Application folder"
fi

if [ -e /Applications/McAfee\ Endpoint\ Protection\ for\ Mac.app ] 
then
	echo "McAfee Endpoint Protection for Mac found in the Application folder, uninstalling..."
	/usr/local/McAfee/uninstall EPM
else
	echo "No McAfee Endpoint Protection for Mac found in the Application folder"
fi

if [ -e /Applications/McAfee\ Security.app ] 
then
	echo "McAfee Security found in the Application folder, uninstalling..."
	/usr/local/McAfee/uninstallMSC
else
	echo "No McAfee Security found in the Application folder"
fi

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0