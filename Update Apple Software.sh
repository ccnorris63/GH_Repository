#!/bin/sh
exec >> "/Library/Logs/Getty Installations.log" 2>&1 

# Last modified May 11, 2017, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
softwareupdate --list
echo " "
softwareupdate --install
sleep 5
echo "********** $0 Complete" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
exit $?

