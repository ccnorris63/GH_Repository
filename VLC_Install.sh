#!/bin/sh
exec >> "/Library/Logs/Getty Installations.log" 2>&1 

DATE=`date "+%A %m/%d/%Y %H:%M"`
# Last modified February 16, 2017, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
VLCVER="3.0.7.1"

echo "Mounting /private/tmp/vlc-$VLCVER.dmg..."
hdiutil attach -nobrowse /private/tmp/"vlc-$VLCVER.dmg"
ls -la /Volumes
echo "Copying VLC.app to Applications folder..."
cp -rf /Volumes/"VLC media player"/VLC.app /Applications

echo "Dismounting /Volumes/"VLC media player"..."
sudo umount -vf /Volumes/"VLC media player"

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0
