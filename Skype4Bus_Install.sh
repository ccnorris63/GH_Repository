#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1
# Last updated June 19, 2018 Chris Norris

SFBVER="16.18.0.51"

echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "

echo "Installing Skype For Business version $SFBVER...."
sudo installer -pkg /private/tmp/SkypeForBusinessInstaller-$SFBVER.pkg -target /

if (test $? = 0) then
	date '+%A %m/%d/%Y %H:%M:%S  Skype For Business was installed successfully.'
else
	date '+%A %m/%d/%Y %H:%M:%S  Skype For Business installation failed.'
fi
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit $?