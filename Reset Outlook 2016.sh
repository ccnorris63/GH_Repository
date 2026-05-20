#!/bin/sh

#quit Outlook to avoid conflicts.
osascript -e 'quit app "outlook"'
sleep 1
osascript -e 'quit app "Word"'
sleep 1
osascript -e 'quit app "Excel"'
sleep 1
osascript -e 'quit app "Powerpoint"'

#Give it a second to quit
sleep 1

#Delete the First Run flags
sudo -s -u workstation defaults delete com.microsoft.Outlook kSubUIAppCompletedFirstRunSetup1507
sudo -s -u workstation defaults delete com.microsoft.Outlook FirstRunExperienceCompletedO15

#Reset First Run Tags
sudo -s -u workstation defaults write com.microsoft.Outlook FirstRunExperienceCompletedO15 -bool false
sudo -s -u workstation defaults write com.microsoft.Outlook kSubUIAppCompletedFirstRunSetup1507 -bool false
sudo -s -u workstation defaults write com.microsoft.Word kSubUIAppCompletedFirstRunSetup1507 -bool false
sudo -s -u workstation defaults write com.microsoft.Excel kSubUIAppCompletedFirstRunSetup1507 -bool false
sudo -s -u workstation defaults write com.microsoft.Powerpoint kSubUIAppCompletedFirstRunSetup1507 -bool false

#Delete the main Outlook profile
rm -rf /Users/workstation/Library/Group\ Containers/UBF8T346G9.Office/Outlook/Outlook\ 15\ Profiles/Main\ Profile 

#Delete the keychain
rm -Rf /Users/$USER/Library/Keychains/*

#Create New login.keychain with password "getty"
security create-keychain -p getty login.keychain

#Set no timeout on new keychain
security set-keychain-settings -u login.keychain