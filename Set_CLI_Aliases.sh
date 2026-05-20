#!/bin/sh
# Last modified April 03, 2018, Chris Norris
exec >> "/Library/Logs/Getty Script.log" 2>&1

date=`date "+%A %m/%d/%Y"`
printf "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********\n"
printf "\n"

ADDALIAS() {
echo 'alias jamfremove="sudo /Library/Getty/scripts/JAMFRemoval.sh"' >> /Users/"${USER_UID}"/.bash_profile
echo 'alias ediscovery="/Library/Getty/scripts/emaildiscovery.sh"' >> /Users/"${USER_UID}"/.bash_profile
echo 'alias resetremacc="sudo /Library/Getty/scripts/resetRemoteAccess.sh"' >> /Users/"${USER_UID}"/.bash_profile
echo 'alias map2ad="sudo /Library/Getty/scripts/Map2AD.sh"' >> /Users/"${USER_UID}"/.bash_profile
}

for USER_HOME in /Users/*
  do
    USER_UID=`basename "${USER_HOME}"`
    if [ ! "${USER_UID}" = "Shared" ] 
    then 
        if [ -f /Users/"${USER_UID}"/.bash_profile ] 
        then
            ADDALIAS
        else
            touch /Users/"${USER_UID}"/.bash_profile
            ADDALIAS
        fi
    fi
  done

printf "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********\n"
printf "\n"
exit $?
