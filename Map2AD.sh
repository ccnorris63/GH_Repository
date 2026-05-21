#!/bin/bash
# Last modified May 09, 2019, Chris Norris

echo "********* $0" `date "+%A %m/%d/%Y %H:%M"`" *********"

# Mapping a system to AD and converting a local account to a network account

# VARIABLES, DEFINED *@*@*@*@*@*@*@*@*@*@*@*@*@*@*@*@*@*@
DateCollect=$(date +"%m%d%Y")
ADUser=macUser
ADUserpsswd=macUser123
ComputerName=`scutil --get ComputerName`
TechAccount=`whoami`

# SUBROUTINES *@*@*@*@*@*@*@*@*@*@*@*@*@*@*@*@*@*@
Exit_Now() {
echo “Exiting Now”
/usr/bin/osascript -e '
tell application "Finder"
	activate
    display dialog "Cancelling AD Mapping and Exiting Now..." buttons ("Ok") default button "Ok" with title "AD Mapping Cancellation"
end tell'
exit 0
}

ConfirmADMAP() {
#echo ""
#echo "Do you want to map this system, $ComputerName, to AD? (y/n)"
#read ADPROCLOOP
#if [ $ADPROCLOOP != "y" ]; then
#	Exit_Now;
#fi
echo "Do you want to map this system, $ComputerName, to AD?"
/usr/bin/osascript <<-EOF
display dialog "Do you want to map this system, $ComputerName, to AD?" buttons {"No", "Yes"} default button 1 with title "Comfirm Mapping to Active Directory"
if button returned of result = "No" then
	display alert "Not Mapping to Active Directory"
	Exit_Now;
else if button returned of result = "Yes" then
	(read ADPROCLOOP)
end if
EOF
}

ConfirmACCT2AD() {
#echo ""
#echo "Do you want to convert a local account to a network account? (y/n)"
#read ACCTPROCLOOP
echo "Do you want to convert a local account to a network account?"
/usr/bin/osascript <<-EOF
display dialog "Do you want to convert a local account to a network account?" buttons {"No", "Yes"} default button 1 with title "Comfirm Local Account Conversion"
if button returned of result = "No" then
	display alert "Not Converting Local Account to Network Account"
else if button returned of result = "Yes" then
	(read ACCTPROCLOOP)
end if
EOF

}

GetUserAcct() {
# Get the local username. 
echo ""
echo "To start, we need to know the local user account being converted. "
echo "Opening the /Users Folder. Find the account home folder..."
sleep 2
open /Users
echo "Drag and drop the user's account folder here, then hit <Enter>:"
read USERACCT
USRACCT=`basename $USERACCT`
osascript -e 'tell application "Finder" to close window "Users"'
echo ""
echo "Please confirm the local username is $USRACCT (y/n):"
read PATHLOOP
if [ $PATHLOOP != "y" ]; then
	GetUserAcct;
fi
}

GetNetAcct() {
# Get the network username.
echo "Opening 411 in Safari. Find the email username, same as the network username... "
sleep 2
open -a /Applications/Safari.app http://go/eGuide/servlet/eGuide
echo ""
echo "What is the username for the email account (before the @ sign) as shown in 411? "
echo ""
echo "Type or copy the username here, then hit <Enter>::"
read NETACCT
osascript -e 'quit app "Safari"'
echo ""
echo "Please confirm the network username is $NETACCT (y/n):"
read PATHLOOP
if [ $PATHLOOP != "y" ]; then
	GetNetAcct;
fi
echo ""
echo "The process will finish then reboot your system"
echo "After your system reboots and the user logs in, check the Getty_ADmapping.log"
echo "in the Console under /Library/Logs to see the results"
echo ""
}

CompareUsrNet() {
echo ""
if [ "$USRACCT" != "$NETACCT" ]; then
	echo "The user's local username is not the same as their network username."
	echo "Changing the name of the user’s local folder to their network username..."
	mv /Users/"$USRACCT" /Users/"$NETACCT"
else
	echo "The user's local username is the same as their network username."
fi 
}

DeleteUsrDir() {
printf " \n"
printf "Deleting the user from the local directory... \n"
dscl . delete /Users/"$USRACCT"
printf "Done \n"
printf " \n"
}

Bind2AD() {
printf "Binding the system to Active Directory... \n"
Laptop=`/usr/sbin/system_profiler SPHardwareDataType | grep "Model Name" | awk '{print $3}'`
printf "Laptop Value = $Laptop \n"
if [ "$Laptop" == "MacBook" ]
then
	yes y | dsconfigad -a "$ComputerName" -u "$ADUser" -p "$ADUserpsswd" -ou "OU=MAC OS X,OU=workstations,DC=CompanyName,DC=com" -domain CompanyName.edu packetsign require -packetencrypt ssl -mobile enable -mobileconfirm enable -localhome enable -useuncpath enable -alldomains enable
else
	yes y | dsconfigad -a "$ComputerName" -u "$ADUser" -p "$ADUserpsswd" -ou "OU=MAC OS X,OU=workstations,DC=CompanyName,DC=com" -domain CompanyName.edu packetsign require -packetencrypt ssl -localhome enable -useuncpath enable -alldomains enable
fi
printf "Done \n"
printf " \n"
}

SetUsrFldrOwnr() {
printf "Set the user folder ownership and permissions... \n"
chown -Rf "$NETACCT":"GETTY\Domain Users" /Users/"$NETACCT"
printf "Done \n"
printf " \n"
}

MakeUsrAdmin() {
printf "Make the account an admin by adding it to the admin group... \n"
dscl . -append /Groups/admin GroupMembership "$NetAccount"
printf "Done \n"
printf " \n"
}

CheckUserStatus() {
printf " \n"
printf "Is $NetAccount now a member of the admin group: \n"
dseditgroup -o checkmember -m "$NetAccount" admin
dseditgroup -o read admin | grep -A6 GroupMembership
printf " \n"
printf "Current AD configuration on $ComputerName: \n"
dsconfigad -show
}

# MAIN BODY OF SCRIPT *@*@*@*@*@*@*@*@*@*@*@*@*@*@*@*@*@*@

ConfirmADMAP;
GetUserAcct;
GetNetAcct;
exec >> "/Library/Logs/Getty_ADmapping.log" 2>&1
if [ $ADPROCLOOP = "y" ]; then
	Bind2AD;
fi
if [ $ACCTPROCLOOP = "y" ]; then
	DeleteUsrDir;
	CompareUsrNet;
	SetUsrFldrOwnr;
	MakeUsrAdmin;
	CheckUserStatus;
fi

printf " \n"
printf " \n"
printf "Rebooting to finish conversion and check into the JSS... \n"
sleep 10
shutdown -r now

echo "********* $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" *********"
exit 0