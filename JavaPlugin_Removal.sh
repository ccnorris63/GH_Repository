#!/bin/bash
#
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1
DATE=`date "+%A %m/%d/%Y %H:%M"`
echo " "
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "

echo "This removes the existing java plug-in and the javaws to prep for a new java plug-in installation."
echo "Removing Library/Internet Plug-Ins/JavaAppletPlugin.plugin..."
rm -rfv /Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin
echo "Removing /usr/bin/javaws..."
mv -v /usr/bin/javaws /usr/bin/javaws.old
echo "Removing /Library/PreferencePanes/JavaControlPanel.prefpane..."
rm -rfv /Library/PreferencePanes/JavaControlPanel.prefpane

echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
exit 0
