#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1

# Last modified March 20, 2018, Chris Norris

echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
#Installs Microsoft's pkg for Office 2016 Suite but omits OneNote
# Runs the Microsoft Volume License Serializer, omiting the need for a specific license number or sign in to Office 365

installer -pkg /private/tmp/Microsoft_Office_2016_15.37.17081500_Volume_Installer.pkg -target / -applyChoiceChangesXML /private/tmp/Off2016Updchoices.xml
sleep 2
/usr/local/jamf/bin/jamf policy -event Off2016Upd
installer -pkg /private/tmp/Microsoft_Office_2016_VL_Serializer_2.0.pkg -target /

if (test $? = 0) then
	date '+%A %m/%d/%Y %H:%M:%S  Microsoft Office 2016 Base version was installed successfully.'
else
	date '+%A %m/%d/%Y %H:%M:%S  Microsoft Office 2016 Base version installation failed.'
fi
echo ""
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit $?