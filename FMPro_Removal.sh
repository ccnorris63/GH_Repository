#!/bin/sh
exec >> "/Library/Logs/Getty Installations.log" 2>&1

# Last modified September 14, 2015, Chris Norris
DATE=`date "+%A %m/%d/%Y %H:%M"`

echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "

# assigned versions to an array
FMPvers=( 11 12 "12 Advanced" 14 "14 Advanced" 16 "16 Advanced")

for i in "${FMPvers[@]}"
do 
	if [ ! -d "/Applications/FileMaker Pro $i" ]
	then
		echo " The FileMaker Pro $i folder was NOT found, no files have been removed"
	else
		echo "The FileMaker Pro $i folder was found in the Applications folder; Killing the FileMaker Pro process..."
		killall -v "FileMaker Pro"

        echo "Deleting the application and receipts..."
		sudo rm -rfv /Applications/"FileMaker Pro $i"
		sudo rm -rfv /Applications/FileMaker*
		sudo rm -rfv /Library/Application\ Support/JAMF/Receipts/FileMaker*
		echo ""
		echo "Removing iODBC; Deleting the associated files..."
		sudo rm -rfv /usr/local/iODBC
		sudo rm -rfv /Library/Frameworks/iODBCadm.framework
		sudo rm -rfv /Library/Application\ Support/iODBC
		sudo rm -rfv /Library/ODBC
		sudo rm -rfv /Library/Application\ Support/JAMF/Receipts/FileMaker*
        sudo rm -rfv /Library/Application\ Support/JAMF/Receipts/FMP*
        # Remove FMPro files from each account in the Users folder
        for USER_HOME in /Users/*
        do
        USER_UID=`basename "${USER_HOME}"`
        if [ ! "${USER_UID}" = "Shared" ]
        then
            if [ -f /Users/"${USER_UID}"/Library/Preferences/com.filemaker.client.pro12.plist ]
            then
            echo ""
            echo "Renaming com.filemaker.client.pro12.plist to save for new install"
            mv -fv /Users/"${USER_UID}"/Library/Preferences/com.filemaker.client.pro12.plist /Users/"${USER_UID}"/Library/Preferences/com.filemaker.client.pro12.save
            fi
            
            if [ -f /Users/"${USER_UID}"/Library/Preferences/com.filemaker.client.advanced12.plist ]
            then
            echo ""
            echo "Renaming com.filemaker.client.advanced12.plist to save for new install"
            mv -fv /Users/"${USER_UID}"/Library/Preferences/com.filemaker.client.advanced12.plist /Users/"${USER_UID}"/Library/Preferences/com.filemaker.client.advanced12.save
            fi

            echo ""
            echo "Removing files from the User's /Library/Application Support, Cache, and Preferences folder items..."
            sudo rm -rfv /Users/"${USER_UID}"/Library/"Application Support"/FileMaker/*
            sudo rm -rfv /Users/"${USER_UID}"/Library/"Application Support"/FileMaker
            sudo rm -rfv /Users/"${USER_UID}"/Library/Caches/com.filemaker.client.pro12
            sudo rm -rfv /Users/"${USER_UID}"/Library/Caches/FileMaker
            sudo rm -fv /Users/"${USER_UID}"/Library/Preferences/com.filemaker.client.pro.plist
            sudo rm -fv /Users/"${USER_UID}"/Library/Logs/FileMaker_iODBC_Installer.log
        fi
        done
	fi
done

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "

exit 0