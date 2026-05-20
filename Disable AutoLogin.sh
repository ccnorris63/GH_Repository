#!/bin/sh
exec >> "/Library/Logs/CompanyName Script.log" 2>&1

date=`date "+%A %m/%d/%Y"`
echo " "
echo "********** $0" `date "+%A %m/%d/%Y %H:%M:%S"`" **********"
echo "Deleting any auto login..."
defaults delete /Library/Preferences/com.apple.loginwindow autoLoginUser
rm -fv /etc/kcpassword
echo "Setting login window to prompt for username and password..."
defaults write /Library/Preferences/com.apple.loginwindow SHOWFULLNAME -bool true

echo " "
echo "********** $0 Complete" `date "+%A %m/%d/%Y %H:%M:%S"`" **********"
echo " "
exit $?
