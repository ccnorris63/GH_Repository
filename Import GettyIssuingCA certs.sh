#!/bin/sh
exec >> "/Library/Logs/Getty Installations.log" 2>&1

date=`date "+%A %m/%d/%Y"`

printf "********** $0" `date "+%A %m/%d/%Y %H:%M:%S"`" **********\n"
printf "\n"
printf "Importing GettyIssuingCA-Aries certificate...\n"
/usr/bin/security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain "/private/tmp/GettyIssuingCA-Aries.cer"

printf "Importing GettyIssuingCA-Athena certificate...\n"
/usr/bin/security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain "/private/tmp/GettyIssuingCA-Athena.cer"

printf "Importing GettyIssuingCA-Mars certificate...\n"
/usr/bin/security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain "/private/tmp/GettyIssuingCA-Mars.cer"

printf "\n"
printf "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M:%S"`" **********\n"
exit 0