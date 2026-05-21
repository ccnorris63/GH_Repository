#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1 

# Last modified February 21, 2017, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
if [ -e "/System/Library/User Template/English.lproj/Desktop/Go to Outlook Web Access.command" ]
then
    rm -fv /System/Library/User\ Template/English.lproj/Desktop/"Go to Outlook Web Access.command"
fi

if [ -e "/System/Library/User Template/English.lproj/Desktop/Outlook Web Access.command" ]
then
    rm -fv /System/Library/User\ Template/English.lproj/Desktop/"Outlook Web Access.command"
fi

for USER_HOME in /Users/*
  do
    USER_UID=`basename "${USER_HOME}"`
    if [ ! "${USER_UID}" = "Shared" ] 
    then
    	if [ -e "/Users/${USER_UID}/Desktop/Go to Outlook Web Access.command" ];then
            rm -rfv "/Users/${USER_UID}/Desktop/Go to Outlook Web Access.command"
        fi
        if [ -e "/Users/${USER_UID}/Desktop/Outlook Web Access.command" ];then
            rm -rfv "/Users/${USER_UID}/Desktop/Outlook Web Access.command"
        fi
    	cp -rfv "/private/tmp/Outlook Web Access/Outlook Web Access.app" /Users/"${USER_UID}"/Desktop
	fi
  done

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit $?
