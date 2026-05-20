#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1

date=`date "+%A %m/%d/%Y"`

printf "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********\n"
printf "\n"
printf "Importing ServerROOTCA certificate...\n"
/usr/bin/security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain "/private/tmp/ServerROOTCA.cer"
printf "\n"
printf "********** $0 Completed " `date "+%A %m/%d/%Y %H:%M"`" **********\n"
exit 0