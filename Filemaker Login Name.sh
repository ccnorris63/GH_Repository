#!/bin/bash
# Last modified Nov 02, 2017, Paul E. Mullins

#Set a variable to the currently logged on User's shortname
UAccount=$(logname)

#If the plist file doesn't exist, copy a fresh version to the User's Preferences folder. This scenario happens when a new local account is created on a machine that already has filemaker installed.
#if [ ! -e "/Users/$UAccount/Library/Preferences/com.filemaker.client.pro12.plist" ]; then
#sudo -u $UAccount cp /private/tmp/com.filemaker.client.pro12.plist /Users/$UAccount/Library/Preferences/
#sleep 2
#fi

#Change preferences from using the System name, to the "other" field
sudo -u $UAccount defaults write /Users/$UAccount/Library/Preferences/com.filemaker.client.pro12.plist Preferences:AppGenOptions -int 2186

#Populate the "other" field with the current logged in User's shortname.
sudo -u $UAccount defaults write /Users/$UAccount/Library/Preferences/com.filemaker.client.pro12.plist Preferences:UserName -string $UAccount

echo "********* $0 Completed" $UAccount `date "+%A %m/%d/%Y %H:%M"`" *********"
exit 0