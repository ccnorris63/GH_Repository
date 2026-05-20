#!/bin/sh
exec >> "/Library/Logs/Getty Installations.log" 2>&1
date=`date "+%A %m/%d/%Y %H:%M"`

echo " "
echo "********** $0" `date "+%A %m/%d/%Y %H:%M:%S"`" **********"
echo " "
echo "Loaded Cylance launchdaemons..."
launchctl list | grep cylance
echo " "
echo "Quiting the Cylance UI (on menu bar)..."
osascript -e 'quit app "CylanceUI"'
echo "UnLoading Cylance Protect launchdaemon..." 
launchctl unload /Library/launchdaemons/com.cylance.agent_service.plist
echo "UnLoading Cylance Protect launchAgent..."
launchctl unload /Library/LaunchAgents/com.cylancePROTECT.plist
killall CylancePROTECT
sleep 3
echo " "
echo "Remaining 3rd party launchagents..."
launchctl list | grep -v com.apple
echo "Remaining 3rd party launchdaemons..."
sudo launchctl list | grep -v com.apple

rm -rfv /Applications/Cylance 
rm -rfv /Library/Application\ Support/Cylance
rm -rfv /Library/LaunchAgents/com.cylancePROTECT.plist
rm -rfv /Library/LaunchDaemons/com.cylance.agent_service.plist

# User files
for USER_HOME in /Users/*
  do
    USER_UID=`basename "${USER_HOME}"`
    if [ ! "${USER_UID}" = "Shared" ] 
    then 
    	echo "********** Removing Cylance elements in the account: ${USER_UID}"
		rm -rfv /Users/"${USER_UID}"/Library/Preferences/com.cylance.CylanceUI.plist
    fi
  done

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M:%S"`" **********"

exit 0