#!/bin/sh
exec >> "/Library/Logs/Getty Script.log" 2>&1

# last updated 09/29/2017, Chris Norris
date=`date "+%A %m/%d/%Y %H:%M"`
printf "\n"
printf "********** $0" `date "+%A %m/%d/%Y %H:%M:%S"`" **********\n"
printf " \n"

chown root:wheel /Library/LaunchAgents/edu.getty.togglewireless.plist
chown root:wheel /Library/Getty/scripts/ToggleWireless.sh
chmod 755 /Library/LaunchAgents/edu.getty.togglewireless.plist

if [[ -e /Library/LaunchAgents/edu.getty.togglewireless.plist ]]
then
    launchctl load -w /Library/LaunchAgents/edu.getty.togglewireless.plist
else
    printf "The edu.getty.togglewireless.plist was not found in /Library/LaunchAgents\n"
fi
printf "\n"
printf "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M:%S"`" **********\n"
printf "\n"
exit 0