#!/bin/sh
exec >> "/Library/Logs/CompanyName Script.log" 2>&1

# Last modified December 7, 2015, Chris Norris
DATE=`date "+%A %m/%d/%Y %H:%M"`

echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
OS=`sw_vers -productVersion | cut -d . -f2`

if [ $OS -gt 9 ]
then
    if [ ! -f /private/var/db/com.apple.xpc.launchd/config ]
    then
        sudo mkdir -m 755 /private/var/db/com.apple.xpc.launchd/config
    fi
    sudo launchctl config user umask 002
    sudo launchctl config system umask 002
else
    touch /private/etc/launchd-user.conf
    echo "umask 002" >> /private/etc/launchd-user.conf
    touch /private/etc/launchd.conf
    echo "umask 002" >> /private/etc/launchd.conf
fi

echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"
exit 0
