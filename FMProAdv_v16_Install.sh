#!/bin/sh
exec  >> "/Library/Logs/CompanyName Installations.log" 2>&1
# Last modified May 08, 2018, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
CurrAcct=$(logname)
shopt -s nocasematch
case "$CurrAcct" in
    username1) FMPA16Serial="123-abc" ;;
    username2) FMPA16Serial="123-xyz" ;;
    username3) FMPA16Serial="456-abc" ;;
    4) FMPA16Serial="456-xyz" ;;
    *) echo "User is not on FMPro Advanced License List."; exit 1 ;;
esac

/bin/echo "AI_USERNAME=

AI_ORGANIZATION=CompanyName

AI_LICENSEKEY=$FMPA16Serial

AI_APPLICATIONUSERS=ALLUSERS

AI_NONEWDATABASES=0

AI_REGISTRATION=1

AI_SKIPDIALOG=1

AI_DISABLEUPDATENOTIFY=0

AI_DISABLEVERSIONNOTIFY=0

AI_DISABLEPLUGINS=0

AI_DISABLEXDBC=0

AI_DISABLEIWP=0

AI_NOGETSTARTEDDIALOGONLAUNCH=1
" > /private/tmp/FMProAdv_16/Assisted\ Install.txt
sleep 2
sudo installer -pkg /private/tmp/FMProAdv_16/FileMaker\ Pro\ 16\ Advanced.pkg -target /
sleep 2
sudo installer -pkg /private/tmp/FMProAdv_16/FileMaker\ Pro\ 169.192.222.111\ Advanced\ Updates.pkg -target /
sleep 2
sudo installer -pkg /private/tmp/FMProAdv_16/FileMaker\ Pro\ 169.192.222.111\ Advanced\ Updates.pkg -target /
sleep 2
sudo installer -pkg /private/tmp/FMProAdv_16/FileMaker\ Pro\ 169.192.222.111\ Advanced\ Updates.pkg -target /

# Copy com.filemaker.client.pro12.save to com.filemaker.client.pro12.plist in each account
for USER_HOME in /Users/*
do
    USER_UID=`basename "${USER_HOME}"`
    if [ ! "${USER_UID}" = "Shared" ]
    then
        echo "Copying com.filemaker.client.pro12.plist from /private/tmp for new install"
        mv -fv /private/tmp/com.filemaker.client.pro12.plist /private/tmp/com.filemaker.client.advanced12.plist
        cp -fpv /private/tmp/com.filemaker.client.advanced12.plist "${USER_HOME}"/Library/Preferences/com.filemaker.client.advanced12.plist
        chown "${USER_UID}" "${USER_HOME}"/Library/Preferences/com.filemaker.client.pro12.plist
    fi
done
killall Dock

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0
