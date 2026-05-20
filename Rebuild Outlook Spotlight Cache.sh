#!/bin/sh
exec >> "/Library/Logs/Getty Script.log" 2>&1

DATE=`date "+%A %m/%d/%Y %H:%M"`

echo " "
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "

# Get Current Logged In User (In Apple-Approved Manner)
loggedInUser=`python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");'`

# Switch to current logged-in user to run script 
su $loggedInUser

#rebuild Spotlight Cache of Outlook messages and Tasks using Microsoft supplied plugin
mdimport -g /Applications/Microsoft\ Outlook.app/Contents/Library/Spotlight/Microsoft\ Outlook\ Spotlight\ Importer.mdimporter -d1 ~/Library/Group\ Containers/UBF8T346G9.Office/Outlook/Outlook\ 15\ Profiles/Main\ Profile 