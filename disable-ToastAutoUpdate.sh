#!/bin/sh
exec >> "/Library/Logs/CompanyName Script.log" 2>&1

SCRIPTNAME=$0

echo " "
echo "*********************************** $SCRIPTNAME" `date "+%A %m/%d/%Y %H:%M:%S"`" *********************************"
echo " "
#----------------------------------------------------------
#   Variables
#----------------------------------------------------------

# --- assignment ---

# --- directories ---
rootLib="/private/var/root/Library"

# --- computationals ---
DATE=`date "+%A %m/%d/%Y %H:%M"`

for i in /Users/*
do
	echo "Disabling Toast Auto-Update in the $i account..."
	defaults write /Users/$i/Library/Preferences/com.roxio.Toast SUEnableAutomaticChecks -int 0
done

echo "                                   "
	echo "Disabling Toast Auto-Update in the root account..."
defaults write $rootLib/Preferences/com.roxio.Toast SUEnableAutomaticChecks -int 0

for i in /System/Library/User\ Template/*
do
	echo "Deleting Toast/Roxio files from the $i user template..."
	defaults write /System/Library/User\ Template/$i/Library/Preferences/com.roxio.Toast SUEnableAutomaticChecks -int 0
done

echo " "
echo "*********************************** $SCRIPTNAME Completed" `date "+%A %m/%d/%Y %H:%M:%S"`" *********************************"
echo " "

exit 0