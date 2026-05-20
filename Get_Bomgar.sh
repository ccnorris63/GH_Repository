#!/bin/bash
exec >> "/Library/Logs/CompnayName Installations.log" 2>&1
# Last modified December 10, 2018, Chris Norris
/bin/echo ""
/bin/echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
/bin/echo ""
BomgarDMG="bomgar-scc-123456789.dmg"
i="0"
DsktpApp="Remote Assistance.app"

until [ -e "/private/tmp/$BomgarDMG" ] || [ $i = "3" ]
do
    /bin/echo "Not Found: $BomgarDMG..."
    /bin/echo "waiting..."
    i=$[$i+1]
    sleep 5
done
if [ ! -e "/private/tmp/$BomgarDMG" ] && [ $i = "3" ]
then
    /bin/echo "Still Not Found: $BomgarDMG..."
    exit 0
fi
echo "Found: $BomgarDMG..."
echo "Removing quarantine attribute from bomgar-scc-remotesupport.dmg..."
sudo xattr -d com.apple.quarantine /private/tmp/$BomgarDMG

echo "Mounting $BomgarDMG..."
hdiutil attach -nobrowse /private/tmp/$BomgarDMG

ls /Volumes/bomgar-scc
/Volumes/bomgar-scc/"Double-Click To Start Support Session.app"/Contents/MacOS/sdcust

i="0"
until [ -e "/Users/$USER/Desktop/$DsktpApp" ] || [ $i = "5" ]
do
    /bin/echo "Not Found: $DsktpApp..."
    /bin/echo "waiting..."
    i=$[$i+1]
    sleep 5
done

echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"
/bin/echo ""
exit 0