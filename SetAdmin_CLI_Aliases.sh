#!/bin/sh
# Last modified April 03, 2018, Chris Norris
exec >> "/Library/Logs/Getty Script.log" 2>&1

date=`date "+%A %m/%d/%Y"`
printf "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********\n"
printf "\n"

ADMINUSER=(root gettytech itslabadmin)

ADDALIAS() {
echo "Adding Alias for Local Getty Scripts..."
echo 'alias jamfremove="sudo /Library/Getty/scripts/JAMFRemoval.sh"' >> /private/var/"${ADMINUSER}"/.bash_profile
echo 'alias ediscovery="/Library/Getty/scripts/emaildiscovery.sh"' >> /private/var/"${ADMINUSER}"/.bash_profile
echo 'alias resetremacc="sudo /Library/Getty/scripts/resetRemoteAccess.sh"' >> /private/var/"${ADMINUSER}"/.bash_profile
echo 'alias map2ad="sudo /Library/Getty/scripts/Map2AD.sh"' >> /private/var/"${ADMINUSER}"/.bash_profile
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
