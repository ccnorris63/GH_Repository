#!/bin/sh
exec >> "/Library/Logs/Getty Installations.log" 2>&1

date=`date "+%A %m/%d/%Y %H:%M"`

echo " "
echo "********** $0" `date "+%A %m/%d/%Y %H:%M:%S"`" **********"
echo " "
if [ -e /Users/Shared/MigrateOld2New.sh ];then
    echo "Removing Old MigrateOld2New.sh..."
    rm -fv /Users/Shared/MigrateOld2New.sh
fi
if [ -e /Users/Shared/MigrateO2N.sh ];then
    echo "Removing Old MigrateO2N.sh..."
    rm -fv /Users/Shared/MigrateO2N.sh
fi
if [ -e /Applications/Utilities/MigrateOld2New.app ];then
    echo "Removing Old MigrateOld2New.app..."
    rm -fv /Applications/Utilities/MigrateOld2New*
fi
echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M:%S"`" **********"

exit 0