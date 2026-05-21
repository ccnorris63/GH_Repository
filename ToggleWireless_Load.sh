#!/bin/sh
exec >> "/Library/Logs/CompanyName Script.log" 2>&1

# last updated 09/29/2017, Chris Norris
date=`date "+%A %m/%d/%Y %H:%M"`
printf "\n"
printf "********** $0" `date "+%A %m/%d/%Y %H:%M:%S"`" **********\n"
printf " \n"

chown root:wheel /Library/LaunchAgents/edu.CompanyName.togglewireless.plist
chown root:wheel /Library/CompanyName/scripts/ToggleWireless.sh
chmod 755 /Library/LaunchAgents/edu.CompanyName.togglewireless.plist

if [[ -e /Library/LaunchAgents/edu.CompanyName.togglewireless.plist ]]
then
    launchctl load -w /Library/LaunchAgents/edu.CompanyName.togglewireless.plist
else
    printf "The edu.CompanyName.togglewireless.plist was not found in /Library/LaunchAgents\n"
fi
printf "\n"
printf "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M:%S"`" **********\n"
printf "\n"
exit 0