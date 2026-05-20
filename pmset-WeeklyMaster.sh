#!/bin/sh
exec >> "/Library/Logs/Getty Script.log" 2>&1

echo " "
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
echo "Set weekly schedule for all macs to wakeup/poweron"
echo "Wednesday mornings @ 12:30am and then shut down @ 4:30am"
pmset repeat wakeorpoweron W 00:30:00 shutdown W 04:30:00

echo "Get pmset schedule"
pmset -g sched
echo "********** $0 Completed " `date "+%A %m/%d/%Y %H:%M"`" **********"
exit 0