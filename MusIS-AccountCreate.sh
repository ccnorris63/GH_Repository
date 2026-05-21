#!/bin/sh
exec >> "/Library/Logs/CompanyName Script.log" 2>&1

echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
 
# Last modified Jan. 7, 2014, Chris Norris

# variables
# ---------------------------------------------------------
ACCT=DeptName
GenericPW='CompanyName'

echo "If account is already created, abort. If not, create it."

if [[ $(dscl . -search /Users RecordName $ACCT) ]]; then
	echo "The $ACCT account already exists."
else
	/usr/local/jamf/bin/jamf createAccount -username $ACCT -realname $ACCT -password $GenericPW -home /Users/$ACCT -hiddenUser -admin
	dseditgroup -o edit -a $ACCT -t user com.apple.access_ssh
fi

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "

exit 0