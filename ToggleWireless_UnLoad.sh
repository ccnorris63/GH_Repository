#!/bin/sh
exec >> "/Library/Logs/CompanyName Script.log" 2>&1

# last updated 09/29/2017, Chris Norris
date=`date "+%A %m/%d/%Y %H:%M"`
CurrAcct=$(logname)

printf "\n"
printf "********** $0" `date "+%A %m/%d/%Y %H:%M:%S"`" **********\n"
printf " \n"

if [[ -e /Library/LaunchAgents/edu.CompanyName.togglewireless.plist ]]
then
    launchctl unload -w /Library/LaunchAgents/edu.CompanyName.togglewireless.plist
    rm -fv /Library/LaunchAgents/edu.CompanyName.togglewireless.plist
    rm -fv /Library/CompanyName/scripts/ToggleWireless.sh
else
    printf "The edu.CompanyName.togglewireless.plist was not found in /Library/LaunchAgents\n"
fi
printf "\n"
printf "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M:%S"`" **********\n"

exit 0