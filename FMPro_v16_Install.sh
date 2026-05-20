#!/bin/sh
exec >> "/Library/Logs/Getty Installations.log" 2>&1 

# Last modified May 08, 2018, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
sudo installer -pkg /private/tmp/FMPro_16/FileMaker\ Pro\ 16.pkg -target /
sleep 5
sudo installer -pkg /private/tmp/FMPro_16/FileMaker\ Pro\ 16.0.3.302\ Updates.pkg -target /
sleep 5
sudo installer -pkg /private/tmp/FMPro_16/FileMaker\ Pro\ 16.0.4.403\ Updates.pkg -target /
sleep 5
sudo installer -pkg /private/tmp/FMPro_16/FileMaker\ Pro\ 16.0.5.500\ Updates.pkg -target /

for USER_HOME in /Users/*
do
    USER_UID=`basename "${USER_HOME}"`
    if [ ! "${USER_UID}" = "Shared" ]
    then
        echo "Copying com.filemaker.client.pro12.plist from /private/tmp for new install"
        cp -fpv /private/tmp/com.filemaker.client.pro12.plist "${USER_HOME}"/Library/Preferences
        chown "${USER_UID}" "${USER_HOME}"/Library/Preferences/com.filemaker.client.pro12.plist
    fi
done
cp -fpv /private/tmp/com.filemaker.client.pro12.plist /System/Library/User\ Template/English.lproj/Library/Preferences
chown root /System/Library/User\ Template/English.lproj/Library/Preferences/com.filemaker.client.pro12.plist

killall Dock

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0
