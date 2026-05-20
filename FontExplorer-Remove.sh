#!/bin/sh
exec >> "/Library/Logs/Getty Script.log" 2>&1

echo " "
echo "*********************************** $0" `date "+%A %m/%d/%Y %H:%M"`" *********************************"
echo " "

# Assign Variables
il="/Applications/Adobe Illustrator"
id="/Applications/Adobe InDesign"
ps="/Applications/Adobe Photoshop"
cs=( CS3 CS4 CS5 'CS5.5' CS6 CC 'CC 2015' 'CC 2016' 'CC 2017' 'CC 2018' 'CC 2019' ) # use of array allows us to add later releases
adb=`ps -ax | grep "Adobe" | grep -v grep | awk '{print $1}'`
fxp=`ps -ax | grep "FontExplorer X Pro" | grep -v grep | awk '{print $1}'`
over500=`dscl . list /Users UniqueID | awk '$2 > 500 { print $1 }'`

echo "Force quit any Adobe & Font Explorer processes..."
# ---------------------------------------------------------
kill -1 ${adb} 2>/dev/null
kill -1 ${fxp} 2>/dev/null

echo "Delete the FontExplorerX Pro application and reciepts..."
rm -drv /Applications/FontExplorer\ X\ Pro.app
rm -drv /Library/Application\ Support/JAMF/Receipts/FontExplorer*.dmg
rm -drv /Library/Receipts/FontExplorer*.pkg

echo "Backup database, Delete Client License, Cache files, all other application components in each user account..."
for i in $over500
do
	cp -pv /Users/$i/Library/Application\ Support/Linotype/FontExplorer\ X/FontExplorer\ X.fexdb /Users/$i/Library/Application\ Support/Linotype/FontExplorer\ X/FontExplorer\ X.fexdb.save
	rm -dr /Users/$i/Library/Application\ Support/Linotype/FontExplorer\ X/ClientLicense.fcl
	rm -dr /Users/$i/Library/Caches/Metadata/FontExplorer X
	rm -dr /Users/$i/Library/Spotlight/FontMDI.mdimporter/Contents/Resources/FontExplorerXSpotlightPlugIn.icns
done

# delete root user files
rm -dr /private/var/root/FontExplorer\ X
rm -dr /private/var/root/Library/Application\ Support/Linotype/FontExplorer\ X
rm -dr /private/var/root/Library/Caches/Metadata/FontExplorer\ X
rm -dr /private/var/root/Library/Application\ Support/Linotype
echo "                                   "


echo "For each version of CS and delete the Font Explorer plug-in..."
for i in "${cs[@]}"
do
	if [ -d "$il $i" ]; then
		echo "Checking for Font Explorer Plug-in for Illustrator $i..."
		rm -drv "$il $i/Plug-ins.localized/FontExplorer"*
		if [ $? = 0 ]; then
			echo "Font Explorer Plug-in for Illustrator $i has been deleted."
		else
			echo "No Font Explorer Plug-in for Illustrator $i found."
		fi
	else
		echo "No Illustrator $i found."
	fi
	
	if [ -d "$ps $i" ]; then
		echo "Checking for Font Explorer Plug-in for Photoshop $i..."
		rm -drv "$ps $i/Plug-Ins/FontExplorer"*
		if [ $? = 0 ]; then
			echo "Font Explorer Plug-in for Photoshop $i has been deleted."
		else
			echo "No Font Explorer Plug-in for Photoshop $i found."
		fi
	else
		echo "No Font Explorer Plug-in for Photoshop $i found."
	fi
	
	if [ -d "$id $i" ]; then
		echo "Checking for Font Explorer Plug-in for InDesign $i..."
		rm -drv "$id $i/Plug-Ins/FontExplorer"*
		if [ $? = 0 ]; then
			echo "Font Explorer Plug-in for InDesign $i has been deleted."
		else
			echo "No Font Explorer Plug-in for InDesign $i found."
		fi
	else
		echo "No Font Explorer Plug-in for InDesign $i found."
	fi
done

echo " "
echo "*********************************** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" *********************************"
echo " "

exit 0