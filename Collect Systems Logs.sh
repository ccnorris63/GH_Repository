#!/bin/sh

# Last updated 8/01/2018, Chris Norris
ZIPDATE=`date +"%m-%d-%Y_%H%M"`
CPUNAME=`scutil --get ComputerName`
#ZIPEMAIL=(username1) 
ZIPEMAIL=(username1 username2 username3)
GDCenter="IP address"
GDVilla="IP address"

exec >> "/Library/Logs/CompanyName Script.log" 2>&1

echo "@*@*@*@*@*@*@*@*@*@* $0" `date "+%A %m/%d/%Y %H:%M"`" @*@*@*@*@*@*@*@*@*@*"
echo "\tComputerName:\t$CPUNAME"
HSTNAME=`scutil --get HostName`
echo "\tHostName:\t$HSTNAME"
LHSTNAME=`scutil --get LocalHostName`
echo "\tLocalHostName:\t$LHSTNAME"

echo "@*@*@*@*@*@*@*@*@*@*@*@*@*@*@*@*@*@*@*@*"
echo "Create ZipLog Directory Paths..."
mkdir -p /Library/CompanyName/ZipLogs/"$CPUNAME"_$ZIPDATE/System_logs
mkdir -p /Library/CompanyName/ZipLogs/"$CPUNAME"_$ZIPDATE/Library_logs

echo "Copy Logs to ZipLog Directories..."
cp -pRf /private/var/log/* /Library/CompanyName/ZipLogs/"$CPUNAME"_$ZIPDATE/System_logs
cp -pRf /Library/Logs/* /Library/CompanyName/ZipLogs/"$CPUNAME"_$ZIPDATE/Library_logs

echo "Create User Directories & Copy User Logs for each..."
for USER_HOME in /Users/*
  do
    USER_UID=`basename "${USER_HOME}"`
	if [ ! "${USER_UID}" = "Shared" ] 
    then 
		echo "Create ZipLog User "${USER_UID}" Directory Paths:"
		mkdir -p /Library/CompanyName/ZipLogs/"$CPUNAME"_$ZIPDATE/User_logs
		echo "Copy ${USER_HOME} Logs to ZipLog Directories:"
		cp -Rf ${USER_HOME}/Library/Logs/* /Library/Getty/ZipLogs/"$CPUNAME"_$ZIPDATE/User_logs
	fi
  done
echo "Zip the $CPUNAME_$ZIPDATE folder..."
cd /Library/CompanyName/ZipLogs
zip -r "$CPUNAME"_ziplogs_$ZIPDATE /Library/CompanyName/ZipLogs/"$CPUNAME"_$ZIPDATE
ls -l /Library/CompanyName/ZipLogs/

echo "Create Mountpoint for smb://GDLab-NAS-Villa/Macintosh_NAS_Villa:"
if [ ! -f /Volumes/Macintosh_NAS_Villa ]
	then 
		mkdir /Volumes/Macintosh_NAS_Villa
fi
echo "Mount smb://GDLab-NAS-GC:"
mount -t smbfs //admin:pa55w0rd@153.10.222.115/Macintosh_NAS_Villa /Volumes/Macintosh_NAS_Villa

echo "Copy ZipLog Package to Directories:"
cp -rv /Library/CompanyName/ZipLogs/"$CPUNAME"_ziplogs_$ZIPDATE.zip /Volumes/Macintosh_NAS_Villa/TechSupport_Testing/ZipLogs/
cp -rv /Library/CompanyName/ZipLogs/"$CPUNAME"_ziplogs_$ZIPDATE.zip /Users/Shared/
echo "Unmount /Volumes/Macintosh_NAS_Villa"
umount /Volumes/Macintosh_NAS_Villa

echo "@*@*@*@*@*@*@*@*@*@* $0 Completed @*@*@*@*@*@*@*@*@*@*"

ZMAILTEXT="The logs from from $CPUNAME on $ZIPDATE have been zipped and copied to the GDLab-NAS-Villa in the  GDLab/Macintosh NAS/TechSupport_Testing/ZipLogs folder. Check with the Lab for a copy."
sleep 3
for i in ${ZIPEMAIL[@]}
  do
  	echo $ZMAILTEXT | mail -s "Zipped Logs from $CPUNAME on $ZIPDATE" $i@CompanyName.com
  done

exit 0
