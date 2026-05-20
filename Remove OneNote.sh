#!/bin/bash

exec >> "/Library/Logs/Getty Installations.log" 2>&1

echo " "
echo "********** $0" `date "+%A %m/%d/%Y %H:%M:%S"`" **********"
echo " "

# file = "/Applications/Microsoft\ OneNote.app"

#if App exists then delete it

if [ -e /Applications/Microsoft\ OneNote.app ]
then
 rm -rf /Applications/Microsoft\ OneNote.app
 echo "OneNote Deleted"
 else
 echo "OneNote Not Present"
fi
exit 0