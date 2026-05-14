#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1

# Last modified September 4, 2018, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"` " **********"
echo ""
echo "deleting com.apple.quarantine attribute from installer..."
xattr -d com.apple.quarantine /private/tmp/CaptureOne.Mac.11.2.1.dmg

echo "Mounting CaptureOne.Mac.11.2.1.dmg..."
yes y | hdiutil attach -nobrowse /private/tmp/CaptureOne.Mac.11.2.1.dmg

open /Volumes/Capture\ One\ 11/

echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"` " **********"
exit 0