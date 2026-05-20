#!/bin/sh
exec >> "/Library/Logs/Getty Script.log" 2>&1

date=`date "+%A %m/%d/%Y"`
echo "********** $0" `date "+%A %m/%d/%Y %H:%M:%S"`" **********"
echo ""
echo "Remove any saved application states..."
rm -r '~/Library/Saved Application State/*'

echo "Set the permissions so nothing can write a Saved State..."
chmod -R a-w '~/Library/Saved Application State'

echo "Disable reopening windows after login..."
defaults write com.apple.loginwindow TALLogoutSavesState -bool false
chmod a-w ~/Library/Preferences/com.apple.loginwindow.plist
sudo chown root ~/Library/Preferences/com.apple.loginwindow.plist

defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false
defaults write -g ApplePersistence -bool false

echo "********** $0 Complete" `date "+%A %m/%d/%Y %H:%M:%S"`" **********"