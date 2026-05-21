#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1

# Last modified June 11, 2019, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo "Installing Office 2016 Update...."
echo ""

UPDV="16.16.19071500"

echo "Installing Office 2016 $UPDV Update...."
sudo installer -pkg /private/tmp/Microsoft_Office_"$UPDV"_Installer.pkg -target / -applyChoiceChangesXML /private/tmp/Off2016Updchoices.xml

if (test $? = 0) then
	date '+%A %m/%d/%Y %H:%M:%S  Microsoft Office 2016 was updated successfully.'
else
	date '+%A %m/%d/%Y %H:%M:%S  Microsoft Office update failed.'
fi
echo ""
echo "********** $0 Complete" `date "+%A %m/%d/%Y %H:%M"`" **********"
exit $?