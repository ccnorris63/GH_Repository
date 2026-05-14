#!/bin/bash
# Last modified December 11, 2018, Chris Norris
# Thank you to RManly at GitHub for this script
# https://gist.github.com/rmanly/6f44648fd21881a66ccc

exec >> "/Library/Logs/CompanyName Script.log" 2>&1 
date=`date "+%A %m/%d/%Y"`
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "

#loggedInUser=$(stat -f%Su /dev/console)
#loggedInUID=$(id -u "$loggedInUser")

#/bin/launchctl asuser "$loggedInUID" sudo -iu "$loggedInUser" 
echo "Prompting for Asset NUMBER..."

/usr/bin/osascript << EOF 
property asstName : ""
repeat while asstName is ""
    tell application "Finder"
        activate
        display dialog "Enter just the ASSET NUMBER  **[e.g: 39876]**  of this system?" default answer asstName
        set asstName to text returned of result
        try
      		if asstName = "" then error
      		exit repeat
   		on error
            beep
      		display alert "Please enter the ASSET NUMBER **[e.g: 39876]** to continue."
   		end try
    end tell
end repeat
try
    do shell script "hostname " & quoted form of asstName 
on error errorMsg number errorNum
    display alert "Error " & errorNum message errorMsg buttons "Cancel" default button 1
end try
EOF

name=$(hostname)
scutil --set ComputerName "GT${name}"
scutil --set LocalHostName "GT${name}"
scutil --set HostName "GT${name}"

scutil --get ComputerName
scutil --get LocalHostName
scutil --get HostName
echo ""
echo "Running an inventory..."
sudo /usr/local/jamf/bin/jamf recon
echo ""
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0