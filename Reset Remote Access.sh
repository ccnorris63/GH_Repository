#!/bin/sh
exec >> "/Library/Logs/CompanyName Script.log" 2>&1
# Last modified March 21, 2018, Chris Norris
# --- computationals ---
DATE=`date "+%A %m/%d/%Y %H:%M"`
echo ""
echo "********** $0 " `date "+%A %m/%d/%Y %H:%M:%S"` " **********" 
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -allowAccessFor -specifiedUsers
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -users itslabadmin,gettytech -access -on -privs -all -clientopts -setreqperm -reqperm yes
echo "********** $0 Completed " `date "+%A %m/%d/%Y %H:%M:%S"` " **********"
echo ""
exit 0
