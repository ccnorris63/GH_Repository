#!/bin/sh
exec >> "/Library/Logs/ITSadmin Scripts.log" 2>&1

SCRIPTNAME=$0

# Last modified Nov. 12, 2013, Chris Norris

echo "***************************** $SCRIPTNAME " 'date "+%A %m/%d/%Y %H:%M:%S"' " **********" 

# set variables
build=`sw_vers | grep ProductVersion | cut -c 20`
os=`sw_vers | grep ProductVersion | cut -c 17-20`
ARD="/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart"

echo "Create user account folder structure…"
mkdir -v /private/var/ITSadmin

echo "=========== Create ARD Account ============"
dseditgroup -o edit -a ITSadmin -t user admin -P ITSadminpass -r ITSadmin
dscl . -create /Users/ITSadmin NFSHomeDirectory /private/var/ITSadmin
sleep 5
chown -Rv ITSadmin /private/var/ITSadmin
dscl . -create /Users/ITSadmin PrimaryGroupID 80
dscl . -create /Users/ITSadmin UniqueID 405
dscl . -create /Users/ITSadmin shell /bin/bash

echo "Verify ITSadmin Account was created properly..."
echo "list /Users | grep ITSadmin:"
dscl . -list /Users | grep ITSadmin

echo "read  /Users/ITSadmin GeneratedUID:"
dscl . -read /Users/ITSadmin GeneratedUID

echo "read /Users/ITSadmin realname:"
dscl . -read /Users/ITSadmin realname

echo "read /Users/ITSadmin NFSHomeDirectory:"
dscl . -read /Users/ITSadmin NFSHomeDirectory

echo "list /private/var | grep ITSadmin"
ls -la /private/var | grep ITSadmin

echo "read /Users/ITSadmin PrimaryGroupID:"
dscl . -read /Users/ITSadmin PrimaryGroupID

echo "read /Users/ITSadmin UniqueID:"
dscl . -read /Users/ITSadmin UniqueID

echo "read /Users/ITSadmin shell:"
dscl . -read /Users/ITSadmin shell

echo "Add ITSadmin account to the admin group..."
dscl . -append /Groups/admin GroupMembership ITSadmin
echo "Verify ARD Account was added to /Groups/admin..."
dscl . -read /Groups/admin GroupMembership

echo "hide ITSadmin account from login and fast user switching menu…"
sudo defaults write /Library/Preferences/com.apple.loginwindow Hide500Users -bool TRUE
sudo defaults write /Library/Preferences/com.apple.loginwindow HiddenUsersList -array add ard

echo "Verify ITSadmin Account was hidden..."
sudo defaults read /Library/Preferences/com.apple.loginwindow Hide500Users
sudo defaults read /Library/Preferences/com.apple.loginwindow HiddenUsersList

# different versions of the OS require different ARD commands
echo "your OS is $os and ARD will now be configured for proper Getty access"
$ARD -activate
$ARD -configure -allowAccessFor -specifiedUsers
$ARD -configure -users ITSadmin -access -on -privs -DeleteFiles -ControlObserve -TextMessages -OpenQuitApps -GenerateReports -RestartShutdown -SendFiles -ChangeSettings -clientopts -setreqperm -reqperm yes

echo "The ITSadmin account has been created, ARD Service access set."

exit 0


