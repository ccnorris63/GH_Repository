#!/bin/sh
exec >> print | tee "/Library/Logs/Getty Scripts.log" 2>&1 

SCRIPTNAME=$0

# Last modified Aug. 21, 2013, Chris Norris
echo "*********************************** $SCRIPTNAME" `date "+%A %m/%d/%Y %H:%M"`" *********************************"
echo " "

# == variables ==
DateCollect=$(date +"%m%d%Y")

CollectLogs() {
echo "What is the User's Asset Number? \c"
read AsstNo
echo "You entered Asset $AsstNo"
ULogFolder="$AsstNo-$DateCollect"

echo "What is the User's IP Address? \c"
read IPAddr
echo "You entered an IPv4 of: $IPAddr"
AsstIP="$IPAddr"
SysOnline=$(ping -c1 $IPAddr | grep "64 bytes" | cut -c1-2)

if [ "$SysOnline" != "64" ]
then
	echo "SysOnline = $SysOnline"
	echo "The Asset $AsstNo is not online at IPv4 $IPAddr"
else
	echo "The asset $AsstNo is online:"
	echo "Creating the named folder to save this collection in..."
	mkdir /Users/workstation/Desktop/$ULogFolder
	chmod -R 777 /Users/workstation/Desktop/$ULogFolder
	
	echo ""
	echo "First, enter your account password."
	echo "Authentication: If this is the first time your system is accessing the system,"
	echo "it will ask if you want to add it to your list of remote systems. Respond yes."
	echo ""
	echo "If this is not the first time you accessed the system, enter the System Administrator password."
	echo "The successive password prompts (for each log folder) are for the System Administrator account."
	echo ""
	echo "Starting to copy the /var/log folder..."
	sudo scp -r root@$IPAddr:/var/Log /Users/workstation/Desktop/$ULogFolder
	sudo mv /Users/workstation/Desktop/$ULogFolder/log/ /Users/workstation/Desktop/$ULogFolder/varlogs
	
	echo "/Library/Logs folder..."
	sudo scp -r root@$IPAddr:/Library/Logs /Users/workstation/Desktop/$ULogFolder
	sudo mv /Users/workstation/Desktop/$ULogFolder/Logs/ /Users/workstation/Desktop/$ULogFolder/LibraryLogs
	
	echo "/Users/workstation/LibraryLogs folder..."
	sudo scp -r root@$IPAddr:/Users/workstation/Library/Logs /Users/workstation/Desktop/$ULogFolder
	sudo mv /Users/workstation/Desktop/$ULogFolder/Logs/ /Users/workstation/Desktop/$ULogFolder/UserLogs
	sudo chmod -R 777 /Users/workstation/Desktop/$ULogFolder
fi

echo "Do you want to collect logs from another system? (y/n)\c"
read optloop
if [ $optloop = "y" ]; then
	CollectLogs;
else
	exit_now;
fi
}

exit_now() {
echo ""
echo "Goodbye"
echo ""
exit 0
}

# Initial Menu
echo "Do you want to collect logs from a remote system? (y/n)\c"
read answer
if [ $answer = "y" ]; then
	CollectLogs;
else
	exit_now;
fi
