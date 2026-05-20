#!/bin/sh
# Last modified October 16, 2018, Chris Norris
DATE=`date "+%A %m/%d/%Y %H:%M"`

echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
OS=`sw_vers -productVersion | cut -d "." -f2`
OSINSTALL="Install High Sierra.app"
FSCHECK="/usr/sbin/diskutil info / | awk '/Type \(Bundle\)/ {print $3}'"

echo "This Mac is running OS X: 10."$OS 
if [ $OS <= 12 ]
then
    echo "The OS needs to be 10.13 High Sierra or newer and the file system needs to be APFS in order to re-image."
    sleep 10
else
    if [[ "$FSCHECK" = "apfs" ]]
    then
        "/Applications/$OSINSTALL/Contents/Resources/startosinstall" --eraseinstall --agreetolicense --nointeraction
    else
        "/Applications/$OSINSTALL/Contents/Resources/startosinstall" --converttoapfs YES --agreetolicense --eraseinstall --nointeraction
    fi
fi

echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"
