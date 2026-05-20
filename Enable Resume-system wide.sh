#!/bin/sh
exec >> "/Library/Logs/CompanyName Script.log" 2>&1

date=`date "+%A %m/%d/%Y"`
echo "********** $0" `date "+%A %m/%d/%Y %H:%M:%S"`" **********"
echo ""

echo "Reset the permissions to write a Saved State..."
chmod -R a+w '~/Library/Saved Application State'

echo "Enable reopening windows after login..."
defaults write com.apple.loginwindow TALLogoutSavesState -bool true
chmod a+w ~/Library/Preferences/com.apple.loginwindow.plist
sudo chown $USER ~/Library/Preferences/com.apple.loginwindow.plist

defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool true
defaults write -g ApplePersistence -bool true

echo "********** $0 Complete" `date "+%A %m/%d/%Y %H:%M:%S"`" **********"