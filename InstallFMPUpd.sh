#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1

SCRIPTNAME=$0

echo " "
echo "*********************************** $SCRIPTNAME" `date "+%A %m/%d/%Y %H:%M"`" *********************************"
echo " "

echo "Installing the Filemaker Pro Update…"
installer -verbose -pkg "/usr/local/temp/FileMaker 12v4 Updates.pkg" -target /
rm -rfv /usr/local/temp

if [ -d /usr/local/temp ]; then
	echo "/usr/local/temp has NOT been removed."
else
	echo "/usr/local/temp has been removed successfully."
fi

exit 0
