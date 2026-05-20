#!/bin/sh
exec >> "/Library/Logs/OTW_Upgrade.log" 2>&1 

echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "

for USER_HOME in /Users/*
  do
    USER_UID=`basename "${USER_HOME}"`
    if [ ! "${USER_UID}" = "Shared" ] 
    then 
        if [ -f "/Users/${USER_UID}/Library/Application Support/Oracle/Java/Deployment" ]
        then
            chmod 777 "/Users/${USER_UID}/Library/Application Support/Oracle/Java/Deployment"
        fi
	fi
  done
echo "Removing the OTW Upgrade package..."
rm -rfv /Applications/"10.12.6 Sierra Upgrade.app"

echo "Removing the OTW Upgrade marker..."
rm -fv /Library/Getty/Markers/OTW_Upgrade.txt
rm -rfv /Library/Getty/Markers

echo "Resetting Remote Access..."
/Library/Getty/scripts/resetRemoteAccess.sh
echo "Reinstalling Oracle Java..."
/usr/local/jamf/bin/jamf policy -event OracleJava
echo "Installing newer Onyx version..."
/usr/local/jamf/bin/jamf policy -event OnyxUtil

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0