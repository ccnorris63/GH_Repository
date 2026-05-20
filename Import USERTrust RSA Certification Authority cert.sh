#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1

date=`date "+%A %m/%d/%Y"`

printf "********** $0" `date "+%A %m/%d/%Y %H:%M:%S"`" **********\n"
printf "\n"
printf "Importing USERTrust RSA Certification Authority certificate...\n"
/usr/bin/security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain "/private/tmp/USERTrust RSA Certification Authority.cer"

#for USER_HOME in /Users/*
#  do
#    USER_UID=`basename "${USER_HOME}"`
#    if [ ! "${USER_UID}" = "Shared" ] 
#    then 
#    	/usr/bin/security add-trusted-cert -d -r trustRoot -k /Users/"${USER_UID}"/Library/Keychains/login.keychain "/private/tmp/USERTrust\ RSA\ Certification\ Authority.cer"
#	fi
#  done
printf "\n"
printf "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M:%S"`" **********\n"