#!/bin/sh
exec >> "/Library/Logs/ITSadmin Scripts.log" 2>&1

# Last modified Apr. 13, 2015, Chris Norris

DATE=`date "+%A %m/%d/%Y %H:%M"`
echo "********** $0 " `date "+%A %m/%d/%Y %H:%M:%S"` " **********" 

# set variables
Kickstart="/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart"
UsersCreated=(itstech itsadmin)
GenericPW='password'

echo "=========== Create Administrative Accounts ============"
# Enables Hide500Users to allow hiding accounts
echo "enable hiding accounts from login and fast user switching menu…"
if [[ $(defaults read /Library/Preferences/com.apple.loginwindow Hide500Users) != 1 ]]; then
	echo "The Hide500Users option is Disabled. Changing to Enabled..."
	defaults write /Library/Preferences/com.apple.loginwindow Hide500Users -bool TRUE
else
	echo "The Hide500Users option is already Enabled"
fi

# Checks to see if the SSH access list exists, if not, it is created
if [[ $(dseditgroup com.apple.access_ssh) = "Group not found." ]]; then
	echo "The com.apple.access_ssh group does not exist, so it is being created." 
	dseditgroup -o create com.apple.access_ssh
else
	echo "The com.apple.access_ssh group already exists."
fi

# Checks to see if each account exists, if not, uses the jamf binary to create the account,
# home folder in /private/var, assign the same RealName, and add the account to the SSH access list
for i in ${UsersCreated[@]}
do
    if [[ $(id -F "$i") = "$i" ]] 
    then
	    echo "The $i account already exists."
    else
	    /usr/sbin/jamf createAccount -username $i -realname $i -password $GenericPW -home /private/var/$i -hiddenUser -admin
	    dseditgroup -o edit -a $i -t user com.apple.access_ssh
    fi
done

# sets the proper permissions for ARD access
echo "Remote access will now be configured for proper Getty access"
$Kickstart -activate
$Kickstart -configure -allowAccessFor -specifiedUsers
$Kickstart -configure -users itslabadmin,gettytech -access -on -privs -all -clientopts -setreqperm -reqperm yes

# Displays the hidden accounts information
for ACCT in ${UsersCreated[@]}
do
    echo "Is the $ACCT Account created?"
    if [[ $(id -F "$ACCT") = "$ACCT" ) ]]
	then
		echo "The $ACCT account exists and has the following properties:"
		echo "The account GeneratedUID (guid): \c"
		dscl . -read /Users/$ACCT GeneratedUID | cut -c 15-
		echo ""
		echo "The account PrimaryGroupID: \c"
		dscl . -read /Users/$ACCT PrimaryGroupID | cut -c 17-
		echo ""
		echo "The account UniqueID (uid): \c"
		dscl . -read /Users/$ACCT UniqueID | cut -c 11-
		echo ""
		echo "The account Home Directory: \c"
		dscl . -read /Users/$ACCT NFSHomeDirectory | cut -c 19-
		echo ""
		echo "This is the admin group membership:"
		dscl . -read /Groups/admin GroupMembership | grep GroupMembership | cut -c 18-
		echo ""
		echo "This is the SSH access list:"
		dscl /Local/Default read Groups/com.apple.access_ssh | grep GroupMembership | cut -c 18-
	else
		echo "<result>There in NO $ACCT Account on this system.</result>"
	fi
done

echo "***************************** $0 Completed" `date "+%A %m/%d/%Y %H:%M:%S"` " **********" 

exit 0
