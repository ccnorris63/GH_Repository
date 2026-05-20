#!/bin/sh
exec >> "/Library/Logs/CompanyName Script.log" 2>&1

date=`date "+%A %m/%d/%Y"`
echo " "
echo "********** $0" `date "+%A %m/%d/%Y %H:%M:%S"`" **********"
for USER_HOME in /Users/*
do
USER_UID=`basename "${USER_HOME}"`
if [ ! "${USER_UID}" = "Shared" ]
then
printf "For the ${USER_UID} account:\n"
rm -rfv "${USER_HOME}"/Library/Application\ Support/com.jamfsoftware.selfservice.mac
rm -rfv "${USER_HOME}"/Library/Caches/com.jamfsoftware.selfservice.mac
rm -rfv "${USER_HOME}"/Library/Preferences/com.jamfsoftware.selfservice.mac.plist

rm -rfv /Library/Application\ Support/JAMF/Self\ Service
rm -rfv /Applications/Self\ Service.app

sudo jamf flushPolcyHistory
sudo jamf flushCaches

printf "Running an Inventory:\n"
sudo jamf recon
printf "Checking for any queued policies:\n"
sudo jamf policy
fi
done

echo " "
echo "********** $0 Complete" `date "+%A %m/%d/%Y %H:%M:%S"`" **********"
echo " "
exit 0
