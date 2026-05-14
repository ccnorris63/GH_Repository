#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1

# Last modified February 8, 2017, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"` " **********"
echo ""

echo "Mounting CS4_Download.dmg..."
hdiutil attach -nobrowse "/private/tmp/CS4_Download.dmg"

echo "Directory of /Volumes/ChronoSync..."
ls -la /Volumes/ChronoSync

echo "Installing /Volumes/ChronoSync/Install.pkg"
installer -verbose -pkg /Volumes/ChronoSync/Install.pkg -target /
umount /Volumes/ChronoSync

echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"` " **********"