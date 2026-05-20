#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1

date=`date "+%A %m/%d/%Y"`

printf "********** $0" `date "+%A %m/%d/%Y %H:%M:%S"`" **********\n"
printf "\n"
printf "Importing Server1CA certificate...\n"
/usr/bin/security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain "/private/tmp/Server1CA.cer"

printf "Importing Server2CA certificate...\n"
/usr/bin/security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain "/private/tmp/Server2CA.cer"

printf "Importing Server3CA certificate...\n"
/usr/bin/security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain "/private/tmp/Server3CA.cer"

printf "\n"
printf "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M:%S"`" **********\n"
exit 0