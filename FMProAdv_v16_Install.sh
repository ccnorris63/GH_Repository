#!/bin/sh
exec  >> "/Library/Logs/Getty Installations.log" 2>&1
# Last modified May 08, 2018, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
CurrAcct=$(logname)
shopt -s nocasematch
case "$CurrAcct" in
    msealey) FMPA16Serial="31864-T92X5-X1XV8-V5T9J-XJ44J-VMV2V-TM238" ;;
    DCarson) FMPA16Serial="36N77-89N28-JV5TN-V8J9J-X4132-93XT6-6MMMT" ;;
    labadmin) FMPA16Serial="3MJ9N-NVN97-TJTJ6-1692T-J7KK4-V6V48-N3K6X" ;;
    4) FMPA16Serial="3776V-M7448-VK85N-X3T3X-54T1V-7XMX9-M3552" ;;
    *) echo "User is not on FMPro Advanced License List."; exit 1 ;;
esac

/bin/echo "AI_USERNAME=

AI_ORGANIZATION=THE J. PAUL GETTY TRUST

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
sudo installer -pkg /private/tmp/FMProAdv_16/FileMaker\ Pro\ 16.0.3.302\ Advanced\ Updates.pkg -target /
sleep 2
sudo installer -pkg /private/tmp/FMProAdv_16/FileMaker\ Pro\ 16.0.4.403\ Advanced\ Updates.pkg -target /
sleep 2
sudo installer -pkg /private/tmp/FMProAdv_16/FileMaker\ Pro\ 16.0.5.500\ Advanced\ Updates.pkg -target /

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
