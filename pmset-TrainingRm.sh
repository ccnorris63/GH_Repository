#!/bin/sh
exec >> "/Library/Logs/Getty Script.log" 2>&1

echo " "
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "

# pmset will set weekly schedule for ITS Training Room Macs to...
# wakeup/poweron Thursday mornings @ 12:30am
# and then shut down @ 4:30am

pmset repeat wakeorpoweron R 00:30:00 shutdown MTWRF 17:20:00

# check schedule
pmset -g sched

exit 0