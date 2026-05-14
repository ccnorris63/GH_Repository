#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1

DATE=`date "+%A %m/%d/%Y %H:%M"`
echo " "
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
BridgeVer=$(ls -l /Applications | grep "Adobe Bridge CC" | awk '{print $11 $12}')

echo "Adobe Bridge $BridgeVer was found in the Applications folder"
echo " "
if [[ "$BridgeVer" == "CC" ]]
then
	if [[ -e /Library/Application\ Support/Adobe/Bridge\ CC\ Extensions/Adobe\ Output\ Module ]];then
		echo "Deleting old AOM2013_Mac file set..."
		sudo rm -rfv /Library/Application\ Support/Adobe/Bridge\ CC\ Extensions/Adobe\ Output\ Module
		sudo rm -rfv /Library/Application\ Support/Adobe/Bridge\ CC\ Extensions/AdobeOutputModule.workspace
	fi
	echo " "
	echo "Copying new AOM2013_Mac file set..."	fi
	sudo cp -rf /private/tmp/AOM2013_Mac/Adobe\ Output\ Module /Library/Application\ Support/Adobe/Bridge\ CC\ Extensions
	sudo cp -rf /private/tmp/AOM2013_Mac/AdobeOutputModule.workspace /Library/Application\ Support/Adobe/Bridge\ CC\ Extensions/Workspaces
	sudo chown -R root:admin /Library/Application\ Support/Adobe/Bridge\ CC\ Extensions
	sudo chmod -R +rx /Library/Application\ Support/Adobe/Bridge\ CC\ Extensions
fi
if [[ "$BridgeVer" == "CC2015" ]]
then
	if [[ -e /Library/Application\ Support/Adobe/Bridge\ CC\ 2015\ Extensions/Adobe\ Output\ Module ]];then
		echo "Deleteing old AOM2015_Mac file set..."
		sudo rm -rfv /Library/Application\ Support/Adobe/Bridge\ CC\ 2015\ Extensions/Adobe\ Output\ Module
		sudo rm -rfv /Library/Application\ Support/Adobe/Bridge\ CC\ 2015\ Extensions/AdobeOutputModule.workspace
	fi
	echo " "
	echo "Copying new AOM2015_Mac file set..."
	sudo cp -rfv /private/tmp/AOM2015_Mac/Adobe\ Output\ Module /Library/Application\ Support/Adobe/Bridge\ CC\ 2015\ Extensions
	sudo cp -rfv /private/tmp/AOM2015_Mac/AdobeOutputModule.workspace /Library/Application\ Support/Adobe/Bridge\ CC\ 2015\ Extensions/Workspaces
	sudo chown -R root:admin /Library/Application\ Support/Adobe/Bridge\ CC\ 2015\ Extensions
	sudo chmod -R +rx /Library/Application\ Support/Adobe/Bridge\ CC\ 2015\ Extensions
fi
if [[ "$BridgeVer" == "CC2017" ]]
then
	if [[ -e "/Library/Application Support/Adobe/Bridge CC 2017 Extensions/Adobe Output Module" ]];then
		echo "Deleteing old AOM2017_Mac file set..."
		sudo rm -rfv /Library/Application\ Support/Adobe/Bridge\ CC\ 2017\ Extensions/Adobe\ Output\ Module
		sudo rm -rfv /Library/Application\ Support/Adobe/Bridge\ CC\ 2017\ Extensions/AdobeOutputModule.workspace
	fi
	echo " "
	echo "Copying new AOM2017_Mac file set..."
	sudo cp -rfv /private/tmp/AOM2017_Mac/Adobe\ Output\ Module /Library/Application\ Support/Adobe/Bridge\ CC\ 2017\ Extensions
	sudo cp -rfv /private/tmp/AOM2017_Mac/AdobeOutputModule.workspace /Library/Application\ Support/Adobe/Bridge\ CC\ 2017\ Extensions/Workspaces
	sudo chown -R root:admin /Library/Application\ Support/Adobe/Bridge\ CC\ 2017\ Extensions
	sudo chmod -R +rx /Library/Application\ Support/Adobe/Bridge\ CC\ 2017\ Extensions
fi
echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"