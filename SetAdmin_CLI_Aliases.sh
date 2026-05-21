#!/bin/sh
# Last modified April 03, 2018, Chris Norris
exec >> "/Library/Logs/CompanyName Script.log" 2>&1

date=`date "+%A %m/%d/%Y"`
printf "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********\n"
printf "\n"

ADMINUSER=(root ITStech itsadmin)

ADDALIAS() {
echo "Adding Alias for Local CompanyName Scripts..."
echo 'alias jamfremove="sudo /Library/CompanyName/scripts/JAMFRemoval.sh"' >> /private/var/"${ADMINUSER}"/.bash_profile
echo 'alias ediscovery="/Library/CompanyName/scripts/emaildiscovery.sh"' >> /private/var/"${ADMINUSER}"/.bash_profile
echo 'alias resetremacc="sudo /Library/CompanyName/scripts/resetRemoteAccess.sh"' >> /private/var/"${ADMINUSER}"/.bash_profile
echo 'alias map2ad="sudo /Library/CompanyName/scripts/Map2AD.sh"' >> /private/var/"${ADMINUSER}"/.bash_profile
}

for ADMINHOME in ADMINUSER
    do
        if [ -f /private/var/“${ADMINUSER}”/.bash_profile ] 
        then
            echo "/private/var/${ADMINUSER}/.bash_profile found"
            ADDALIAS;
        else
            echo "No /private/var/${ADMINUSER}/.bash_profile found, creating .bash_profile..."
            touch /private/var/"${ADMINUSER}"/.bash_profile
            ADDALIAS;
        fi
    done
printf "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********\n"
printf "\n"
exit $?
