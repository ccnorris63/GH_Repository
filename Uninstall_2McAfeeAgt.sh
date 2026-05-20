#!/bin/sh
exec >> "/Library/Logs/Getty Installations.log" 2>&1 

echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
if [ -f /Library/McAfee/agent/scripts/uninstall.sh ]
then
    echo "Unloading Mcafee Launch Agents..."
    launchctl unload -w /Library/LaunchDaemons/com.mcafee.agent.ma.plist
    launchctl unload -w /Library/LaunchDaemons/com.mcafee.agent.macmn.plist
    launchctl unload -w /Library/LaunchDaemons/com.mcafee.agent.macompat.plist
    echo "Running uninstall script..."
    /Library/McAfee/agent/scripts/uninstall.sh

    echo "Removing Mcafee Launch Agents and Daemons"
    rm -fv /Library/LaunchDaemons/com.mcafee.agent.ma.plist
    rm -fv /Library/LaunchDaemons/com.mcafee.agent.macmn.plist
    rm -fv /Library/LaunchDaemons/com.mcafee.agent.macompat.plist
    rm -fv /Library/LaunchDaemons/com.mcafee.ssm.Eupdate.plist
    rm -fv /Library/LaunchDaemons/com.mcafee.ssm.ScanFactory.plist
    rm -fv /Library/LaunchDaemons/com.mcafee.ssm.ScanManager.plist
    rm -fv /Library/LaunchDaemons/com.mcafee.virusscan.fmpd.plist

    rm -fv /Library/LaunchAgents/com.mcafee.menulet.plist
    rm -fv /Library/LaunchAgents/com.mcafee.reporter.plist
    rm -fv /Library/LaunchAgents/com.mcafee.McAfeeSafariHost.plist

    echo "Removing Container components"
    rm -rfv /Users/$USER/Library/Containers/com.McAfee.McAfeeSafariHost.McAfeeSafariWCExt
    rm -rfv /Users/$USER/Library/Group Containers/group.com.Mcafee.WebControl

    echo "Removing var/McAfee"
    rm -rfv /private/var/McAfee
    
    echo "Removing etc/cma.*"
    rm -fv /private/etc/cma.conf
    rm -rfv /private/etc/cma.d
else
    echo "No Uninstall script was found."
fi
echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0