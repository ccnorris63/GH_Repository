#!/bin/sh
exec >> "/Library/Logs/CompanyName Script.log" 2>&1

date=`date "+%A %m/%d/%Y"`
echo " "
echo "********** $0" `date "+%A %m/%d/%Y %H:%M:%S"`" **********"
MAC_UUID=`system_profiler SPHardwareDataType | grep "Hardware UUID" | awk '{print $3}'`

echo " Turn OFF automatic updates"
sudo softwareupdate --schedule off

echo "Disable creation of .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
echo "Disable creation of .DS_Store files on USB volumes"
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

echo "Disable automatic login"
defaults delete /Library/Preferences/com.apple.loginwindow autoLoginUser

echo "Disable system-wide resume"
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false
defaults write -g ApplePersistence -bool false
defaults write com.apple.loginwindow TALLogoutSavesState -bool false

echo "Show IP address, hostname, OS version, etc. when clicking clock on login window"
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

echo "Show Hard Drives/Servers"
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.finder calculateAllSizes -bool true

echo "Show all filename extensions..."
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "Set default to list view..."
defaults write com.apple.finder FXPreferredViewStyle Nlsv

echo "Show status, path, & tool bars"
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathBar -bool true
defaults write com.apple.finder ShowToolBar -bool true

echo "Enable Screen Saver clock & enable required password..."
defaults write com.apple.screensaver ShowClock -bool true
defaults write com.apple.screensaver askForPassword -bool true

echo "Set Safari to Show the Favorites Bar..."
defaults write com.apple.Safari ShowFavoritesBar -bool true

echo "Remove com.apple.quarantine xattribute from Firefox and Google Chrome..."
xattr -d -r com.apple.quarantine /Applications/Firefox.app
xattr -d -r com.apple.quarantine /Applications/Google\ Chrome.app

killall cfprefsd
killall Finder
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M:%S"`" **********"
echo " "
exit 0