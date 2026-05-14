#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1 

# Last modified February 20, 2017, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
if [ -e "/System/Library/User Template/English.lproj/Desktop/SpendDynamics.command" ]
then
 rm -fv /System/Library/User\ Template/English.lproj/Desktop/SpendDynamics.command
fi
echo ""

for USER_HOME in /Users/*
  do
    USER_UID=`basename "${USER_HOME}"`
    if [ ! "${USER_UID}" = "Shared" ] 
    then
    	if [ -e "/Users/${USER_UID}/Desktop/Spend Dynamics.app" ];then
            rm -rfv "/Users/${USER_UID}/Desktop/Spend Dynamics.app"
        fi
    	cp -rfv /private/tmp/BMO-SpdDyn/"Spend Dynamics.app" /Users/"${USER_UID}"/Desktop
	fi
  done

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit $?
