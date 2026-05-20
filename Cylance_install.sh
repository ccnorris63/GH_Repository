#!/bin/sh
exec >> "/Library/Logs/Getty Installations.log" 2>&1

echo " "
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
echo "Create the Cylance token and install the Agent..."
echo eK7mYIXuMliwZmH4WENiJIfs > /private/tmp/cyagent_install_token
echo NoCylanceUI="Hidden Agent UI" >> /private/tmp/cyagent_install_token

echo LogLevel=3 >> /private/tmp/cyagent_install_token
sudo installer -pkg /private/tmp/CylancePROTECT.pkg -target /
sleep 10

echo "Unload the Cylance Agent Service... "
launchctl unload /Library/LaunchDaemons/com.cylance.agent_service.plist

echo "Quit the CylanceUI (on the menu bar)... "
osascript -e 'quit app "CylanceUI"'

echo "Current CylancePROTECT launchd settings... "
defaults read /Library/LaunchAgents/com.cylancePROTECT RunAtLoad

echo "Setting the CylancePROTECT launchd RunAtLoad to 0 or OFF... "
defaults write /Library/LaunchAgents/com.cylancePROTECT RunAtLoad 0

echo "New CylancePROTECT launchd settings... "
defaults read /Library/LaunchAgents/com.cylancePROTECT

echo "Hide the Cylance UnInstaller... "
chflags hidden /Applications/Cylance/"Uninstall CylancePROTECT.app"

echo "Load the Cylance Agent Service again... "
launchctl load /Library/LaunchDaemons/com.cylance.agent_service.plist

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"
exit 0