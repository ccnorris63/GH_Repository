#!/bin/sh
exec >> "/Library/Logs/CompanyName Script.log" 2>&1
# Last modified December 10, 2018, Chris Norris

# --- computationals ---
DATE=`date "+%A %m/%d/%Y %H:%M"`

echo "********** $0 " `date "+%A %m/%d/%Y %H:%M:%S"` " **********" 

# set variables
Kickstart="/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart"
UsersCreated=(username1 username2)
GenericPW='ma5ter'

echo "Enable trust of JSS"
sudo jamf trustJSS

echo "Prompting for the Asset Number and assigning the proper Names to the system..."
/usr/local/jamf/bin/jamf policy -event NameChange

echo "=========== Create Administrative Accounts ============"
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
	    echo "The $i account already exists, adding to the SSH access list..."
	    dseditgroup -o edit -a $i -t user com.apple.access_ssh
    else
	    echo "Creating the $i account..."
	    /usr/local/jamf/bin/jamf createAccount -username $i -realname $i -password $GenericPW -home /private/var/$i -hiddenUser -admin
	    echo "adding the $i account to the SSH access list..."
	    dseditgroup -o edit -a $i -t user com.apple.access_ssh
    fi
done

for USER_HOME in /Users/*
  do
    USER_UID=`basename "${USER_HOME}"`
    if [ ! "${USER_UID}" = "Shared" ] 
    then 
	    echo "The $i account already exists, adding to the SSH access list..."
	    dseditgroup -o edit -a $i -t user com.apple.access_ssh
        # echo "Enabling the secureTokenOn attribute to admin accounts..."
        # sysadminctl -adminUser "${USER_UID}" -adminPassword "PASWWORD" -secureTokenOn username1 -password $GenericPW
        # sysadminctl -secureTokenStatus username1
        # sysadminctl -adminUser "${USER_UID}" -adminPassword "PASSWORD" -secureTokenOn username2 -password $GenericPW
        # sysadminctl -secureTokenStatus username2
fi
done

# Adds the Admin group to ssh remote access group
dseditgroup -o edit -a admin -t group com.apple.access_ssh

# sets the proper permissions for ARD access
echo "Remote access will now be configured for proper CompanyName access"
$Kickstart -activate
$Kickstart -configure -allowAccessFor -specifiedUsers
$Kickstart -configure -users itsadmin,Nametech -access -on -privs -all -clientopts -setreqperm -reqperm yes

# Displays the hidden accounts information
for ACCT in ${UsersCreated[@]}
do
    echo "Is the $ACCT Account created?"
    if [[ $(id -F "$ACCT") = "$ACCT" ]]
	then
		echo "The $ACCT account exists and has the following properties:"
		echo "GeneratedUID (guid): \c"
		dscl . -read /Users/$ACCT GeneratedUID | cut -c 15-
		echo "PrimaryGroupID: \c"
		dscl . -read /Users/$ACCT PrimaryGroupID | cut -c 17-
		echo "UniqueID (uid): \c"
		dscl . -read /Users/$ACCT UniqueID | cut -c 11-
		echo "Home Directory: \c"
		dscl . -read /Users/$ACCT NFSHomeDirectory | cut -c 19-
	else
		echo "There in NO $ACCT Account on this system"
	fi
done

echo ""
echo "admin group membership:"
dscl . -read /Groups/admin GroupMembership | grep GroupMembership | cut -c 18-
echo ""
echo "SSH access list:"
dscl /Local/Default read Groups/com.apple.access_ssh | grep GroupMembership | cut -c 18-
echo "Running Reset Admin Account Passwords Policy "
    /usr/local/jamf/bin/jamf policy -event ResetMgmt
    
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M:%S"` " **********" 

exit $?