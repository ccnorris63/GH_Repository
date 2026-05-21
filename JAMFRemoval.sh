#!/bin/sh

exec >> "/Library/Logs/CompanyName Installations.log" 2>&1 
date=`date "+%A %m/%d/%Y"`
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "

echo "First the JAMF framework components:"
if [ -e /usr/local/jamf ];then
    echo "Removing JAMF binaries... "
    rm -rfv /usr/local/jamf
fi

if [ -e /Library/LaunchDaemons/com.jamfsoftware.startupItem.plist ];then
    echo "JAMF launchd items..."
    # Points to where the task, startup script, and login hooks are stored:
    rm -fv /Library/LaunchDaemons/com.jamfsoftware.jamf.daemon.plist
    rm -fv /Library/LaunchDaemons/com.jamfsoftware.startupItem.plist
    rm -fv /Library/LaunchDaemons/com.jamfsoftware.task*
fi

if [ -e /Library/Application\ Support/JAMF/ManagementFrameworkScripts ];then
    echo "The startup script ..."
    rm -fv /Library/Application\ Support/JAMF/ManagementFrameworkScripts/StartupScript.sh
    echo "Login/Logout hooks..."
    rm -fv /Library/Application\ Support/JAMF/ManagementFrameworkScripts/loginhook.sh
    rm -fv /Library/Application\ Support/JAMF/ManagementFrameworkScripts/logouthook.sh
    rm -rfv /Library/Application\ Support/JAMF/ManagementFrameworkScripts
fi

if [ -e  ];then
echo "Restricted Software list..."
rm -rfv /Library/Application\ Support/JAMF/.blacklist.xml
fi

if [ -e /Library/Preferences/com.jamfsoftware.jamf ];then
    echo "JAMF configuration file..."
    # The JAMF configuration file defines the JSS, allows apps to communicate, stores JSS certificate info, and max. clock skew.
    rm -fv /Library/Preferences/com.jamfsoftware.jamf
fi

echo "Now the Storage directories:"

if [ -e /Library/Application\ Support/JAMF/bin ];then
    echo "JAMF Helper used to display messages to end user..."
    rm -rfv /Library/Application\ Support/JAMF/bin
fi

#if [ -e /Library/Application\ Support/JAMF/Composer ];then
#   echo "Composer Work Directory for Package Building..."
#   Keeps record of all package sources that are created with Composer
#   rm -rfv /Library/Application\ Support/JAMF/Composer
#fi

if [ -e /Library/Application\ Support/JAMF/Downloads ];then
    echo "Package Downloads directory..."
    rm -rfv /Library/Application\ Support/JAMF/Downloads
fi

#if [ -e /Library/Application Support/JAMF/Receipts ];then
#   echo "Receipts"
#   Keeps records of all packages installed by the Casper
#   rm -rfv /Library/Application Support/JAMF/Receipts
#fi

if [ -e /Library/Application\ Support/JAMF/Waiting Room ];then
   echo "Cached Software waiting to be deployed..."
   rm -rfv /Library/Application\ Support/JAMF/Waiting Room
fi

if [ -e /Library/Application\ Support/JAMF/run ];then
   echo "Other Application Support/JAMF folders..."
   rm -rfv /Library/Application\ Support/JAMF/run
   rm -rfv /Library/Application\ Support/JAMF/Self\ Service
   rm -rfv /Library/Application\ Support/JAMF/tmp
fi

#if [ -e /Library/Application\ Support/JAMF/Usage ];then
#    echo "Application Usage..."
#    rm -rfv /Library/Application\ Support/JAMF/Usage
#fi

#if [ -e /var/log/jamf.log ];then
#   echo "JAMF log file..."
#   Keeps a record of everything that JAMF Binary does
#   rm -rfv /var/log/jamf.log
#fi

sleep 5
if [ -f /Library/CompanyName/packages/JamfFrame.pkg ];then
	installer -pkg /Library/Getty/packages/QuickAdd.pkg -target /
else
	echo "There was no QuickAdd.pkg found in /Library/Getty/packages."
fi

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0