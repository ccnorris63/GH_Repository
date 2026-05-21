#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1

# Updated script September 18 2018, Chris Norris
DATE=`date "+%A %m/%d/%Y %H:%M"`
echo " "
echo "*********************************** $0" `date "+%A %m/%d/%Y %H:%M"`" *********************************"
echo " "

echo "Force quit all M$ Apps..."
pkill -f Microsoft
killall -v SyncServicesAgent

# Remove the Application and common files
echo ""
echo "Remove the Microsoft Office 2016 Applications:"
rm -drfv /Applications/Microsoft\ Excel.app
rm -drfv /Applications/Microsoft\ OneNote.app
rm -drfv /Applications/Microsoft\ Outlook.app
rm -drfv /Applications/Microsoft\ PowerPoint.app
rm -drfv /Applications/Microsoft\ Word.app

echo ""
echo "Removing files from the /Library folder..."
rm -drfv "/Library/Application Support/Microsoft/MAU2.0"
rm -drfv "/Library/Application Support/Microsoft/MERP2.0"

echo ""
echo "Removing the /Library/Fonts/Microsoft folder..."
rm -drfv /Library/Fonts/Microsoft

echo ""
echo "Removing licensing files from the /Library folder…"
rm -rfv /Library/Preferences/com.microsoft.office.licensing.plist
rm -rfv /Library/Preferences/com.microsoft.office.licensingV2.plist
rm -rfv /Library/LaunchAgents/com.microsoft.update.agent.plist
rm -rfv /Library/LaunchDaemons/com.microsoft.office.licensing.helper.plist
rm -rfv /Library/LaunchDaemons/com.microsoft.autoupdate.helper.plist
rm -rfv /Library/LaunchDaemons/com.microsoft.office.licensingV2.helper.plist
rm -rfv /Library/PrivilegedHelperTools/com.microsoft.office.licensing.helper.plist

echo ""
echo "Removing receipts from the /private/var/db/receipts folder..."
rm -rfv /private/var/db/receipts/com.microsoft.mau*
rm -rfv /private/var/db/receipts/com.microsoft.merp*
rm -rfv /private/var/db/receipts/com.microsoft.office*
rm -rfv /private/var/db/receipts/com.microsoft.rdc
rm -rfv /private/var/db/receipts/com.microsoft.package.Microsoft_AutoUpdate.app.bom
rm -rfv /private/var/db/receipts/com.microsoft.package.Microsoft_AutoUpdate.app.plist
rm -rfv /private/var/db/receipts/com.microsoft.package.Microsoft_Excel.app.bom
rm -rfv /private/var/db/receipts/com.microsoft.package.Microsoft_Excel.app.plist
rm -rfv /private/var/db/receipts/com.microsoft.package.Microsoft_Outlook.app.bom
rm -rfv /private/var/db/receipts/com.microsoft.package.Microsoft_Outlook.app.plist
rm -rfv /private/var/db/receipts/com.microsoft.package.Microsoft_PowerPoint.app.bom
rm -rfv /private/var/db/receipts/com.microsoft.package.Microsoft_PowerPoint.app.plist
rm -rfv /private/var/db/receipts/com.microsoft.package.Microsoft_Word.app.bom
rm -rfv /private/var/db/receipts/com.microsoft.package.Microsoft_Word.app.plist
rm -rfv /private/var/db/receipts/com.microsoft.package.Proofing_Tools.bom
rm -rfv /private/var/db/receipts/com.microsoft.package.Proofing_Tools.plist
rm -rfv /private/var/db/receipts/com.microsoft.pkg.licensing.volume.plist
rm -rfv /private/var/db/receipts/com.microsoft.pkg.licensing.volume.bom
rm -rfv /private/var/db/receipts/com.microsoft.pkg.licensing.plist
rm -rfv /private/var/db/receipts/com.microsoft.pkg.licensing.bom
rm -rfv /private/var/db/receipts/moffice2016noonenote.bom
rm -rfv /private/var/db/receipts/moffice2016noonenote.plist
rm -rfv /private/var/db/BootCaches/69D7B6DF-FA90-43FE-839B-C9B83BF93F86/app.com.microsoft.Word.playlist
rm -rfv /private/tmp/com.microsoft.*


# Remove Microsoft files from each account in the Users folder
 for USER_HOME in /Users/*
  do
    USER_UID=`basename "${USER_HOME}"`
    if [ ! "${USER_UID}" = "Shared" ] 
    then 
    echo ""
    echo "Backing up Users Office folder to Office.save in the Users Application Support folder to use with new install..."
    cp -rpfv "/Users/${USER_UID}/Library/Application Support/Microsoft/Office" "/Users/${USER_UID}/Library/Application Support/Microsoft/Office.save"
    echo ""
    echo "Removing files from the Users /Library/Cache folder..."
    rm -rfv /Users/${USER_UID}/Library/Caches/com.microsoft.Excel
    rm -rfv /Users/${USER_UID}/Library/Caches/com.microsoft.Word
    rm -rfv /Users/${USER_UID}/Library/Caches/com.microsoft.Powerpoint
    rm -drfv /Users/${USER_UID}/Library/Caches/Microsoft
    echo ""
    echo "Removing files from the Users Preferences folder…"
    rm -rfv /Users/${USER_UID}/Library/Preferences/com.microsoft.autoupdate.fba.debuglogging.plist
    rm -rfv /Users/${USER_UID}/Library/Preferences/com.microsoft.autoupdate2.plist
    rm -rfv /Users/${USER_UID}/Library/Preferences/com.microsoft.netlib.shipassertprocess.plist
    rm -rfv /Users/${USER_UID}/Library/Preferences/com.microsoft.error_reporting.plist
    rm -rfv /Users/${USER_UID}/Library/Preferences/com.microsoft.Excel.plist
    rm -rfv /Users/${USER_UID}/Library/Preferences/com.microsoft.office.plist
    rm -rfv /Users/${USER_UID}/Library/Preferences/com.microsoft.outlook.databasedaemon.plist
    rm -rfv /Users/${USER_UID}/Library/Preferences/com.microsoft.outlook.plist
    rm -rfv /Users/${USER_UID}/Library/Preferences/com.microsoft.Office365ServiceV2.plist
    rm -rfv /Users/${USER_UID}/Library/Preferences/com.microsoft.RMS-XPCService.plist
    rm -rfv /Users/${USER_UID}/Library/Preferences/com.microsoft.onenote.mac.plist
    rm -rfv /Users/${USER_UID}/Library/Preferences/com.microsoft.Powerpoint.plist
    rm -rfv /Users/${USER_UID}/Library/Preferences/com.microsoft.rdc.plist
    rm -rfv /Users/${USER_UID}/Library/Preferences/ByHost/com.microsoft.registrationDB.*
	rm -rfv /Users/${USER_UID}/Library/Preferences/ByHost/MicrosoftRegistrationDB.*
    rm -rfv /Users/${USER_UID}/Library/Preferences/com.microsoft.visualbasic.plist
    rm -rfv /Users/${USER_UID}/Library/Preferences/com.microsoft.Word.plist
	rm -drfv /Users/${USER_UID}/Library/Preferences/Microsoft
	echo ""
    echo "Removing files from the Users Containers folders…"
	rm -drfv /Users/${USER_UID}/Library/Group Containers/UBF8T346G9.ms
    rm -drfv /Users/${USER_UID}/Library/Group Containers/UBF8T346G9.Office
    rm -drfv /Users/${USER_UID}/Library/Group Containers/UBF8T346G9.OfficeOsfWebHost
    rm -drfv /Users/${USER_UID}/Library/Containers/com.microsoft.errorreporting
    rm -drfv /Users/${USER_UID}/Library/Containers/com.microsoft.Excel
    rm -drfv /Users/${USER_UID}/Library/Containers/com.microsoft.netlib.shipassertprocess
    rm -drfv /Users/${USER_UID}/Library/Containers/com.microsoft.Office365ServiceV2
    rm -drfv /Users/${USER_UID}/Library/Containers/com.microsoft.Outlook
    rm -drfv /Users/${USER_UID}/Library/Containers/com.microsoft.Powerpoint
    rm -drfv /Users/${USER_UID}/Library/Containers/com.microsoft.RMS-XPCService
    rm -drfv /Users/${USER_UID}/Library/Containers/com.microsoft.Word
    rm -drfv /Users/${USER_UID}/Library/Containers/com.microsoft.onenote.mac
    fi
done

# Remove files from root account
# --------------------------------------------------
rm -drv /private/var/root/Documents/Microsoft\ User\ Data
echo ""
echo "Removing Office folder in the root Application Support folder..."
rm -drv "/private/var/root/Library/Application Support/Microsoft/Office"

echo ""
echo "Removing files from the Root /Library/Cache folder..."
rm -rfv /private/var/root/Library/Caches/com.microsoft.Excel
rm -rfv /private/var/root/Library/Caches/com.microsoft.Word
rm -rfv /private/var/root/Library/Caches/com.microsoft.Powerpoint
rm -rfv /private/var/root/Library/Caches/Microsoft

echo ""
echo "Removing files from the Root account Preferences folder…"
rm -rfv /private/var/root/Library/Preferences/com.microsoft.autoupdate.fba.debuglogging.plist
rm -rfv /private/var/root/Library/Preferences/com.microsoft.autoupdate2.plist
rm -rfv /private/var/root/Library/Preferences/com.microsoft.netlib.shipassertprocess.plist
rm -rfv /private/var/root/Library/Preferences/com.microsoft.error_reporting.plist
rm -rfv /private/var/root/Library/Preferences/com.microsoft.Excel.plist
rm -rfv /private/var/root/Library/Preferences/com.microsoft.office.plist
rm -rfv /private/var/root/Library/Preferences/com.microsoft.outlook.databasedaemon.plist
rm -rfv /private/var/root/Library/Preferences/com.microsoft.outlook.plist
rm -rfv /private/var/root/Library/Preferences/com.microsoft.Office365ServiceV2.plist
rm -rfv /private/var/root/Library/Preferences/com.microsoft.RMS-XPCService.plist
rm -rfv /private/var/root/Library/Preferences/com.microsoft.onenote.mac.plist
rm -rfv /private/var/root/Library/Preferences/com.microsoft.Powerpoint.plist
rm -rfv /private/var/root/Library/Preferences/com.microsoft.rdc.plist
    
rm -rfv /private/var/root/Library/Preferences/ByHost/com.microsoft.registrationDB.*
rm -rfv /private/var/root/Library/Preferences/ByHost/MicrosoftRegistrationDB.*
rm -rfv /private/var/root/Library/Preferences/com.microsoft.visualbasic.plist
rm -rfv /private/var/root/Library/Preferences/com.microsoft.Word.plist
rm -drfv /private/var/root/Library/Preferences/Microsoft
echo ""
echo "Removing files from the Users Containers folders…"
rm -drfv /private/var/root/Library/Group Containers/UBF8T346G9.ms
rm -drfv /private/var/root/Library/Group Containers/UBF8T346G9.Office
rm -drfv /private/var/root/Library/Group Containers/UBF8T346G9.OfficeOsfWebHost
    
rm -drfv /private/var/root/Library/Containers/com.microsoft.errorreporting
rm -drfv /private/var/root/Library/Containers/com.microsoft.Excel
rm -drfv /private/var/root/Library/Containers/com.microsoft.netlib.shipassertprocess
rm -drfv /private/var/root/Library/Containers/com.microsoft.Office365ServiceV2
rm -drfv /private/var/root/Library/Containers/com.microsoft.Outlook
rm -drfv /private/var/root/Library/Containers/com.microsoft.Powerpoint
rm -drfv /private/var/root/Library/Containers/com.microsoft.RMS-XPCService
rm -drfv /private/var/root/Library/Containers/com.microsoft.Word
rm -drfv /private/var/root/Library/Containers/com.microsoft.onenote.mac

echo " "
echo "*********************************** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" *********************************"
echo " "

exit 0