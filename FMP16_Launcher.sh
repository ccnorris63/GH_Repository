#!/bin/sh
exec >> "/Library/Logs/Getty Installations.log" 2>&1 

# Last modified May 14, 2018, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "

for USER_HOME in /Users/*
  do
    USER_UID=`basename "${USER_HOME}"`
    if [ ! "${USER_UID}" = "Shared" ] 
    then 
        cp -fpv /private/tmp/Launch\ Trust\ Pubs\ DB.fmp12 "${USER_HOME}"/Desktop
        chown "${USER_UID}" "${USER_HOME}"/Desktop/Launch\ Trust\ Pubs\ DB.fmp12
        chmod 777 "${USER_HOME}"/Desktop/Launch\ Trust\ Pubs\ DB.fmp12
    fi
  done

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0
