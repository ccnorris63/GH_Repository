#!/bin/bash
exec >> "/Library/Logs/CompanyName Script.log" 2>&1 

# Last modified July 24, 2019, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
MRDVer=`defaults read /Applications/Microsoft\ Remote\ Desktop.app/Contents/Info.plist CFBundleGetInfoString | awk -F'.' '{print $1}'`
echo "MRD Version: $MRDVer"

if [ -e /Applications/Microsoft\ Remote\ Desktop\ 8/Microsoft\ Remote\ Desktop.app ];then
    echo "Microsoft Remote Desktop 8 was found and is now being removed..."
    rm -rfv /Applications/Microsoft\ Remote\ Desktop\ 8/
fi

if [ -e /Applications/Microsoft\ Remote\ Desktop.app ] && [ $MRDVer = 8 ];then
    echo "Microsoft Remote Desktop 8 was found and is now being removed..."
    rm -rfv /Applications/Microsoft\ Remote\ Desktop.app
fi

for USER_HOME in /Users/*
  do
    USER_UID=`basename "${USER_HOME}"`
    if [ ! "${USER_UID}" = "Shared" ] 
    then
    	if [ -e /Users/"${USER_UID}"/Desktop/TMSterm.rdp ]
    	then
    	    echo "TMSterm.rdp was found and is now being removed..."
            rm -fv /Users/"${USER_UID}"/Desktop/TMSterm.rdp
    	fi
        
        if [ -e /Users/"${USER_UID}"/Desktop/TMS.rdp ]
    	then
    	    echo "TMS.rdp was found and is now being removed..."
            rm -fv /Users/"${USER_UID}"/Desktop/TMS.rdp
    	fi

	fi
  done

echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0
