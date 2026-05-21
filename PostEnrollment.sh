#!/bin/sh
## postinstall
# Prepopulate the LAPS extension Attribute
apiURL="https://casper.CompanyName.com:8443"
udid=$(/usr/sbin/system_profiler SPHardwareDataType | /usr/bin/awk '/Hardware UUID:/ { print $3 }')
xmlString="<?xml version=\"1.0\" encoding=\"UTF-8\"?><computer><extension_attributes><extension_attribute><name>LAPS</name><value>getty</value></extension_attribute></extension_attributes></computer>"

/usr/bin/curl -s -f -u GDLAPS:h!gHS3cur179 -X PUT -H "Content-Type: text/xml" -d "${xmlString}" "${apiURL}/JSSResource/computers/udid/$udid"

exec >> "/Library/Logs/CompanyName Installations.log" 2>&1 
date=`date "+%A %m/%d/%Y"`
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "

JTriggers=(
'HPDrivers'
'XDrivers'
'BBEdit'
'FileZilla'
'Firefox'
'GChrome'
'OnyxUtil'
'URLApps'
'AReader'
'VLCPlayer'
'GetBomgar'
'ProdSUS'
'Off2016Base'
'LTSCFonts'
'Palantino'
'VSePO'
'CylanceAgt'
)

JPolicies=(
'HP Drivers'
'Xerox Drivers'
'BBEdit'
'FileZilla'
'Firefox Quantum'
'Google Chrome'
'OnyX Utility'
'Desktop URL Apps'
'Adobe Reader'
'VLC Player'
'Get Remote Assistance App'
'SUS, Production Branch'
'Office 2016 Suite'
'LinotypeSyntaxCom Fonts'
'Palatino v7.0d4e6'
'McAfee Endpoint Security'
'Cylance Protect'
)

# *** Policy Calls & Script Execution ***
if [ ! -e /Library/CompanyName/ImagingLog.txt ]
then
	touch /Library/CompanyName/ImagingLog.txt
fi

i=0
while [ $i -lt ${#JTriggers[*]} ]
do
    echo "********** trigger: ${JTriggers[i]}"
    echo "the current value of i is $i"
    /usr/local/jamf/bin/jamf policy -event ${JTriggers[i]}
    echo "********** writing to ImagingLog.txt"
    echo "${JPolicies[i]} \t Policy called at \t" `date "+%A %m/%d/%Y %H:%M"` >> /Library/CompanyName/ImagingLog.txt
    i=$[$i+1]
    echo " "
done

for USER_HOME in /Users/*
do
      USER_UID=`basename "${USER_HOME}"`
      if [ ! "${USER_UID}" = "Shared" ]
      then 
        echo "Copying the Bookmarks.plist file to the Desktop and setting the POSIX permissions."
        cp -fv /Users/Shared/Bookmarks.plist /Users/"${USER_UID}"/Desktop
        cp -fv /Users/Shared/Bookmarks.html /Users/"${USER_UID}"/Desktop
		chown "${USER_UID}":staff /Users/"${USER_UID}"/Desktop/Bookmarks.plist
		chmod 755 /Users/"${USER_UID}"/Desktop/Bookmarks.plist
		
        if [ ! -d /Users/"${USER_UID}"/Library/Safari ]
		then
			echo "No Safari folder found for ${USER_HOME}, creating one..."
            mkdir -p "${USER_HOME}"/Library/Safari
            chown "${USER_UID}":staff /Users/"${USER_UID}"/Library/Safari
            chmod 755 /Users/"${USER_UID}"/Library/Safari
        else
        	echo "the "${USER_HOME}"/Library/Safari folder already exists."
		fi
        
        echo "Opening "${USER_HOME}"/Library/Safari..."
    	open "${USER_HOME}/Library/Safari"
        
        echo ""
        echo "Drag and drop the Bookmarks.plist file to the users Library/Safari folder. Use the Bookmarks.html file to import the standard Bookmarks into other browsers...."
        /usr/bin/osascript -e '
        tell application "Finder"
        activate
        display dialog "Drag and drop the Bookmarks.plist file to the users Library/Safari folder. Use the Bookmarks.html file to import the standard Bookmarks into other browsers." buttons ("Ok") default button "Ok" with title "Move Bookmarks file"
        end tell'
      fi
done

echo "Installing any Apple software updates..."
sudo softwareupdate -ia
sleep 5

echo "Make the McAfee Agent check in with ePO and enforce policies..."
/Library/McAfee/agent/bin/cmdagent -c
sleep 2
/Library/McAfee/agent/bin/cmdagent -e

echo "display a dialog indicating the end of the imaging process"
/usr/bin/osascript -e '
tell application "Finder"
	activate
    display dialog "The CompanyName Configuration Process has completed. Additional details can be verified in the ImagingLog.txt, jamf, Installations and Script logs. RESTART the system." buttons ("Ok") default button "Ok" with title "Imaging Complete"
end tell'

echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
exit 0