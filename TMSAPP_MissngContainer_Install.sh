#!/bin/bash
exec >> "/Library/Logs/Getty Installations.log" 2>&1 

# Last modified July 03, 2019, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
for USER_HOME in /Users/*
  do
    USER_UID=`basename "${USER_HOME}"`
    if [ ! "${USER_UID}" = "Shared" ] 
    then 
    	if [ ! -e "/Users/${USER_UID}/Library/Containers/com.microsoft.rdc.mac/Data/Library/Preferences" ]
        then
        	mkdir -p /Users/"${USER_UID}"/Library/Containers/com.microsoft.rdc.mac/Data/Library/Preferences
        fi
        cp -rfv /private/tmp/TMSUSER/Library/Containers/com.microsoft.rdc.mac/Data/Library/Preferences/com.microsoft.rdc.mac.plist /Users/"${USER_UID}"/Library/Containers/com.microsoft.rdc.mac/Data/Library/Preferences/
    	chown -R "${USER_UID}":staff /Users/"${USER_UID}"/Library/Containers/com.microsoft.rdc.mac/Data/Library/Preferences/com.microsoft.rdc.mac
	fi
  done

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0
