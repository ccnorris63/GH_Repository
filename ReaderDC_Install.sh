#!/bin/sh
exec >> "/Library/Logs/Getty Installations.log" 2>&1
# Last modified December 18, 2018, Chris Norris

DATE=`date "+%A %m/%d/%Y %H:%M"`
UpdPatch=1901020064
UpdVers="19.010.20064"
CurrVer=$(defaults read "/Applications/Adobe Acrobat Reader DC.app/Contents/Info.plist" CFBundleVersion)

echo "********** $0 " `date "+%A %m/%d/%Y %H:%M:%S"` " **********"

echo "Installed version is $CurrVer"
echo "Reader Patch version is $UpdVers"

if [ ! -e /Applications/Adobe\ Acrobat\ Reader\ DC.app ]
then
    echo "Installing the Adobe Reader DC version v$UpdVers..."
    installer -allowUntrusted -pkg /private/tmp/AcroRdrDC_"$UpdPatch"_MUI.pkg -target /
else
    if [ "$CurrVer">="$UpdVers" ]
    then
		echo "Adobe Reader DC version $CurrVer is already installed. The patch version $UpdPatch is the same or older and will not be installed."
    else
    	echo "The installed Adobe Reader DC version $CurrVer is older. The patch version $UpdPatch will be installed."
        installer -allowUntrusted -pkg /private/tmp/AcroRdrDC_"$UpdPatch"_MUI.pkg -target /
    fi
fi

echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M:%S"` " **********" 

exit 0