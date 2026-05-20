#!/bin/sh
exec >> "/Library/Logs/CompanyName Script.log" 2>&1

# Last modified May 3, 2018, Chris Norris
DATE=`date "+%A %m/%d/%Y %H:%M"`
echo " "
echo "********** $0 " `date "+%A %m/%d/%Y %H:%M:%S"` " **********" 

echo "Create Old_Discoveries folder and move previous Discoveries into it..."
mkdir -p /Users/Shared/Old_Discoveries
mv -fv /Users/Shared/Discovery_GT* /Users/Shared/Old_Discoveries

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M:%S"` " **********"