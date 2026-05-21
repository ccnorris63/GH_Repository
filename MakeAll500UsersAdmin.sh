#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1

# Make All Users Administrative
# runs through all users > UID 500 and makes them admin

### variables
date=`date "+%A %m/%d/%Y %H:%M"`
over500=`dscl . list /Users UniqueID | awk '$2 > 500 { print $1 }'`
admins=`dscl . -read /groups/admin GroupMembership`

echo "                                   "
echo "*********************************** $0 " `date "+%A %m/%d/%Y %H:%M"`" *********************************"

for i in $over500
do
	echo $admins | grep $i
	if [ $? -ne 0 ]; then
		dscl . -append /groups/admin users $i
		echo "$i is NOT already in the admin group"
		echo "The $i account has now been made administrative."
	else
		echo "The $i account is ALREADY administrative."
	fi
done
dscl . -read /groups/admin GroupMembership
dscl . -read /groups/admin GroupMembership


echo "                                   "
echo "*********************************** $SCRIPTNAME Complete" `date "+%A %m/%d/%Y %H:%M"`" *********************************"
exit 0