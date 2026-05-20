#!/bin/bash
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1

date=`date "+%A %m/%d/%Y"`

printf "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********\n"
printf "\n"

for USER_HOME in /Users/*
  do
    USER_UID=`basename "${USER_HOME}"`
    if [ ! "${USER_UID}" = "Shared" ] 
    then 
	    printf "Importing vm-production-app certificate...\n"
	    /usr/bin/security add-trusted-cert -d -r -k /Users/"${USER_UID}"/Library/Keychains/login.keychain-db "/private/tmp/vm-production-app.cer"
	fi
done

printf "\n"
printf "********** $0 Completed " `date "+%A %m/%d/%Y %H:%M"`" **********\n"
exit 0