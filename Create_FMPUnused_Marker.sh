#!/bin/sh
exec >> "Library/Logs/CompanyName Script.log" 2>&1

# Last modified February 08, 2018, Chris Norris
DATE=`date "+%A %m/%d/%Y %H:%M"`

echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
FMPVER="14"
if [ -d "/Applications/FileMaker Pro $FMPVER" ]
then
    if [ ! -e /Library/CompanyName/Markers/FMPUnused.txt ]
    then
        mkdir -p /Library/CompanyName/Markers
        touch /Library/CompanyName/Markers/FMPUnused.txt
        echo "This system has FMPro $FMPVER installed but it has NOT been used" >> /Library/CompanyName/Markers/FMPUnused.txt
    fi
else
    echo "This system does NOT have FMPro $FMPVER installed"
fi
echo "/Library/CompanyName/Markers:"
ls -l@ /Library/CompanyName/Markers
echo " "

echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"
