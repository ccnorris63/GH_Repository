#!/bin/sh
exec >> "/Library/Logs/Getty Installations.log" 2>&1

printf "\n"
printf "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********\n"
printf "\n"
APPNAME="Adobe Photoshop LightRoom 5"

if [ -d "/Applications/Adobe Photoshop Lightroom 5.app" ]
then
    printf "Removing $APPNAME...\n"
    rm -rfv /Applications/Adobe Photoshop Lightroom 5.app
    rm -rfv /Users/$USER/Library/Preferences/com.adobe.Lightroom5.plist
    rm -rfv /Users/$USER/Library/Preferences/com.adobe.Lightroom5.LSSharedFileList.plist
    rm -rfv "/Library/Application Support/Adobe/Lightroom/Lightroom 5.0 Registration"
    rm -rfv "/Library/Application Support/Adobe/Lightroom/Lightroom 5.0 InstallCookie" 
fi

printf "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********\n"
exit 0
