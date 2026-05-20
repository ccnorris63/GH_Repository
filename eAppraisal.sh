#!/bin/sh
exec >> "/Library/Logs/Getty Installations.log" 2>&1 

# Last modified February 13, 2019, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
echo "Remove the old version"
if [ -e "/System/Library/User Template/English.lproj/Desktop/eAppraisal.app" ]
then
    rm -fv /System/Library/User\ Template/English.lproj/Desktop/eAppraisal.app
fi

if [ -e "/Applications/eAppraisal.app" ]
then
    rm -fv /Applications/eAppraisal.app
fi

if [ -e "/Applications/Utilities/eAppraisal.app" ]
then
    rm -fv /Applications/Utilities/eAppraisal.app
fi

for USER_HOME in /Users/*
  do
    USER_UID=`basename "${USER_HOME}"`
    if [ ! "${USER_UID}" = "Shared" ] 
    then
    	if [ -e "/Users/${USER_UID}/Desktop/eAppraisal.app" ];then
            rm -rfv /Users/"${USER_UID}"/Desktop/eAppraisal.app
        fi
    	cp -rfv /private/tmp/eAppraisal/eAppraisal.app /Users/"${USER_UID}"/Desktop
	fi
  done

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit $?
