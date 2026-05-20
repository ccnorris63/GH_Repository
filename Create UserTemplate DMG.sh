#!/bin/sh
exec >> "/Library/Logs/CompanyName Script.log"  2>&1
# Last modified February 14, 2018, Chris Norris

# Set up variables
date=`date "+%m%d%Y"`
UTFolder="/Users/$USER/Desktop/UserTemplate"


# Mark the process beginning in the CompanyName Script.log
echo " "
echo "********** $0" `date "+%A %m/%d/%Y %H:%M:%S"`" **********"

echo "Make the source folder and the substructure needed"
mkdir -pv "$UTFolder"/private/var/db
mkdir -pv "$UTFolder"/System/Library/Preferences/SystemConfiguration
mkdir -pv "$UTFolder"/System/Library/User\ Template/English.lproj/Desktop
mkdir -pv "$UTFolder"/System/Library/User\ Template/English.lproj/Library/Application\ Support/Dock
mkdir -pv "$UTFolder"/System/Library/User\ Template/English.lproj/Library/Application\ Support/Oracle/Java/Deployment/security
mkdir -pv "$UTFolder"/System/Library/User\ Template/English.lproj/Library/Preferences
mkdir -pv "$UTFolder"/System/Library/User\ Template/English.lproj/Library/Safari

echo "Copy the AppleSetupDone file and set the ownership"
cp -fv /private/var/db/.AppleSetupDone "$UTFolder"/private/var/db
chown -v root:wheel "$UTFolder"/private/var/db/.AppleSetupDone

echo "Copy the System Configuration files and set the ownership"
cp -fv /System/Library/Preferences/SystemConfiguration/com.apple.AutoWake.plist "$UTFolder"/System/Library/Preferences/SystemConfiguration
cp -fv /Library/Preferences/com.apple.PowerManagement.plist "$UTFolder"/Library/Preferences
chown -v root:wheel "$UTFolder"/System/Library/Preferences/SystemConfiguration/*

echo "Remove the old shortcuts from English.lproj"
rm -fv /System/Library/User\ Template/English.lproj/Desktop/GoTo_PaymentNet.command
rm -fv /System/Library/User\ Template/English.lproj/Desktop/GoTo_Workforce.command
rm -fv /System/Library/User\ Template/English.lproj/Desktop/Go\ to\ Outlook\ Web\ Access.command

echo "Copy the new shortcuts to English.lproj and the source folder and set the ownership"
cp -fv /Users/$USER/Desktop/Spend\ Dynamics.app /System/Library/User\ Template/English.lproj/Desktop
cp -fv /Users/$USER/Desktop/Workforce.app /System/Library/User\ Template/English.lproj/Desktop
cp -fv /Users/$USER/Desktop/Outlook\ Web\ Access.app /System/Library/User\ Template/English.lproj/Desktop
cp -fv /Users/$USER/Desktop/eAppraisal.app /System/Library/User\ Template/English.lproj/Desktop
chown -v root:wheel /System/Library/User\ Template/English.lproj/Desktop/*

cp -fv /System/Library/User\ Template/English.lproj/Desktop/* "$UTFolder"/System/Library/User\ Template/English.lproj/Desktop
chown -v root:wheel "$UTFolder"/System/Library/User\ Template/English.lproj/Desktop/*


echo "Copy desktop database and java exception list to English.lproj and the source folder and set the ownership"
cp -fv /Users/$USER/Library/Application\ Support/Dock/desktoppicture.db /System/Library/User\ Template/English.lproj/Library/Application\ Support/Dock
cp -fv /Users/$USER/Library/Application\ Support/Oracle/Java/Deployment/security/exception.sites /System/Library/User\ Template/English.lproj/Library/Application\ Support/Oracle/Java/Deployment/security
chown -Rv root:wheel /System/Library/User\ Template/English.lproj/Library/Application\ Support/*

cp -rfv /System/Library/User\ Template/English.lproj/Library/Application\ Support/* "$UTFolder"/System/Library/User\ Template/English.lproj/Library/Application\ Support
chown -Rv root:wheel "$UTFolder"/System/Library/User\ Template/English.lproj/Library/Application\ Support

echo "Copy the user preference files to English.lproj and the source folder and set the ownership"
cp -fv /Users/$USER/Library/Preferences/.GlobalPreferences.plist /System/Library/User\ Template/English.lproj/Library/Preferences
cp -fv /Users/$USER/Library/Preferences/com.apple.AppleMultitouchMouse.plist /System/Library/User\ Template/English.lproj/Library/Preferences
cp -fv /Users/$USER/Library/Preferences/com.apple.AppleMultitouchTrackpad.plist /System/Library/User\ Template/English.lproj/Library/Preferences
cp -fv /Users/$USER/Library/Preferences/com.apple.desktop.plist /System/Library/User\ Template/English.lproj/Library/Preferences
cp -fv /Users/$USER/Library/Preferences/com.apple.dock.plist	/System/Library/User\ Template/English.lproj/Library/Preferences

cp -fv /Users/$USER/Library/Preferences/com.apple.driver.AppleBluetoothMultitouch.mouse.plist /System/Library/User\ Template/English.lproj/Library/Preferences
cp -fv /Users/$USER/Library/Preferences/com.apple.driver.AppleBluetoothMultitouch.trackpad.plist /System/Library/User\ Template/English.lproj/Library/Preferences
cp -fv /Users/$USER/Library/Preferences/com.apple.driver.AppleHIDMouse.plist /System/Library/User\ Template/English.lproj/Library/Preferences
cp -fv /Users/$USER/Library/Preferences/com.apple.finder.plist /System/Library/User\ Template/English.lproj/Library/Preferences
cp -fv /Users/$USER/Library/Preferences/com.apple.menuextra.clock.plist /System/Library/User\ Template/English.lproj/Library/Preferences

cp -fv /Users/$USER/Library/Preferences/com.apple.Safari.plist /System/Library/User\ Template/English.lproj/Library/Preferences
cp -fv /Users/$USER/Library/Preferences/com.apple.screensaver.plist /System/Library/User\ Template/English.lproj/Library/Preferences
cp -fv /Users/$USER/Library/Preferences/com.apple.SetupAssistant.plist /System/Library/User\ Template/English.lproj/Library/Preferences
cp -fv /Users/$USER/Library/Preferences/com.apple.sidebarlists.plist /System/Library/User\ Template/English.lproj/Library/Preferences
cp -fv /Users/$USER/Library/Preferences/com.apple.symbolichotkeys.plist /System/Library/User\ Template/English.lproj/Library/Preferences

chown -v root:wheel /System/Library/User\ Template/English.lproj/Library/Preferences/*

echo "Copy the English.lproj Preference files to the source folder and set the ownership"
cp -fv /System/Library/User\ Template/English.lproj/Library/Preferences/* "$UTFolder"/System/Library/User\ Template/English.lproj/Library/Preferences
chown -v root:wheel "$UTFolder"/System/Library/User\ Template/English.lproj/Library/Preferences/*

echo "Copy the user Safari Bookmarks to English.lproj and the source folder and set the ownership"
cp -fv /Users/$USER/Library/Safari/Bookmarks.plist /System/Library/User\ Template/English.lproj/Library/Safari
chown -v root:wheel /System/Library/User\ Template/English.lproj/Library/Safari/*

cp -fv /System/Library/User\ Template/English.lproj/Library/Safari/* "$UTFolder"/System/Library/User\ Template/English.lproj/Library/Safari
chown -v root:wheel "$UTFolder"/System/Library/User\ Template/English.lproj/Library/Safari/*

echo "Create the UserTemplate.dmg on the Desktop using the source folder"
hdiutil create -srcfolder /Users/$USER/Desktop/UserTemplate -volname "User Template" -fs HFS+ -fsargs "-c c=64,a=16,e=16" -format UDRW -size 10m /Users/$USER/Desktop/UserTemplate_"$date".dmg

# Mark the process ending in the CompanyName Script.log
echo " "
echo "********** $0 Complete" `date "+%A %m/%d/%Y %H:%M:%S"`" **********"
exit 0
