#!/bin/bash
exec >> "/Library/Logs/Getty Installations.log" 2>&1
# Last modified August 30, 2018, Chris Norris
/bin/echo ""
/bin/echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
/bin/echo ""
ETKP="ETKPlus2018"
i="0"

until [ -e "/private/tmp/$ETKP" ] || [ $i = "3" ]
do
    /bin/echo "Not Found: $ETKP..."
    /bin/echo "waiting..."
    i=$[$i+1]
    sleep 5
done
if [ ! -e "/private/tmp/$ETKP" ] && [ $i = "3" ]
then
    /bin/echo "Still Not Found: $ETKP..."
    exit 0
fi
echo "Found: $ETKP..."
echo "Removing quarantine attribute from bomgar-scc-remotesupport.dmg..."
sudo xattr -d com.apple.quarantine /private/tmp/$ETKP

for USER_HOME in /Users/*
do
USER_UID=`basename "${USER_HOME}"`
if [ ! "${USER_UID}" = "Shared" ] 
then
mv -fv /private/tmp/"$ETKP" "/Users/${USER_UID}/Desktop"
chown -R "${USER_UID}":admin "/Users/${USER_UID}/Desktop/$ETKP"
open "/Users/${USER_UID}/Desktop/$ETKP"/ETKPlusInstaller.docm
sleep 10
open "/Users/${USER_UID}/Desktop/$ETKP"/Editor\'s\ ToolKit\ Plus\ 2018\ Instructions.pdf
osascript -e 'set pageNum to "15"'
osascript -e 'tell application "System Events"'
osascript -e 'tell application process "Preview"'
osascript -e 'set frontmost to true'
osascript -e 'keystroke "g" using {option down, command down}'
osascript -e 'repeat until sheet 1 of window 1 exists'
osascript -e 'delay 0.2'
osascript -e 'end repeat'
osascript -e 'keystroke pageNum'
osascript -e 'keystroke return'
osascript -e 'end tell'
osascript -e 'end tell'
fi
done

echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"
/bin/echo ""
exit 0