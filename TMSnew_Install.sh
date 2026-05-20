#!/bin/sh
exec >> "/Library/Logs/Getty Installations.log" 2>&1 

# Last modified April 16, 2018, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
for USER_HOME in /Users/*
  do
    USER_UID=`basename "${USER_HOME}"`
    if [ ! "${USER_UID}" = "Shared" ] 
    then 
    	cp -fv /Users/Shared/TMS.rdp /Users/"${USER_UID}"/Desktop
    	chown "${USER_UID}" /Users/"${USER_UID}"/Desktop/TMS.rdp
	fi
  done

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0
