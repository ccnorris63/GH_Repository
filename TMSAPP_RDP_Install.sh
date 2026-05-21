#!/bin/bash
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1 

# Last modified July 17, 2019, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
for USER_HOME in /Users/*
  do
    USER_UID=`basename "${USER_HOME}"`
    if [ ! "${USER_UID}" = "Shared" ] 
    then 
    	cp -fv /Users/Shared/TMS2018.rdp /Users/"${USER_UID}"/Desktop/"TMS 2018.rdp"
    	chown "${USER_UID}" /Users/"${USER_UID}"/Desktop/"TMS 2018.rdp"
	fi
  done

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0
