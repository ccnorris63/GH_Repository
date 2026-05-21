#!/bin/sh
exec >> "Library/Logs/CompanyName Script.log" 2>&1

# Last modified February 08, 2018, Chris Norris
DATE=`date "+%A %m/%d/%Y %H:%M"`

echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
FMPVER="14"
if [ -d "/Applications/FileMaker Pro $FMPVER" ]
then
    if [ -f /Library/CompanyName/Markers/FMPUnused.txt ]
    then
        echo "This system has FMPro $FMPVER installed and it HAS been used" 
        rm -fv /Library/CompanyName/Markers/FMPUnused.txt
    else
        echo "This system has FMPro $FMPVER installed and is not marked as unused!" 
    fi
else
    echo "This system does NOT have FMPro $FMPVER installed!" 
    rm -fv /Library/CompanyName/Markers/FMPUnused.txt
fi
echo "/Library/CompanyName/Markers:"
ls -l@ /Library/CompanyName/Markers
echo " "

echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"
