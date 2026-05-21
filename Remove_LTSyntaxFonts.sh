#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1 

# Last modified May 30, 2016, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
if [ -e /Library/Fonts/LTSyntax\ Regular.ttf ];then
echo "Location: /Library/Fonts/CompanyName folder"
echo "Removing old /Library/Fonts/CompanyName/LTSyntax fonts ..."
fi
if [ -e /Library/Fonts/CompanyName/LTSyntax\ Regular.ttf ];then
rm -rfv /Library/Fonts/CompanyName/LTSyntax\ Regular.ttf
fi
if [ -e /Library/Fonts/CompanyName/LTSyntax\ OsF\ Regular.ttf ];then
rm -rfv /Library/Fonts/CompanyName/LTSyntax\ OsF\ Regular.ttf
fi
if [ -e /Library/Fonts/CompanyName/LTSyntax\ Bold.ttf ];then
rm -rfv /Library/Fonts/CompanyName/LTSyntax\ Bold.ttf
fi
if [ -e /Library/Fonts/CompanyName/LTSyntax\ OsF\ Bold.ttf ];then
rm -rfv /Library/Fonts/CompanyName/LTSyntax\ OsF\ Bold.ttf
fi
if [ -e /Library/Fonts/CompanyName/LTSyntax\ Italic.ttf ];then
rm -rfv /Library/Fonts/CompanyName/LTSyntax\ Italic.ttf
fi
echo " "
if [ -e /Library/Fonts/LTSyntax\ Regular.ttf ];then
echo "Location: /Library/Fonts folder"
echo "Removing old /Library/Fonts/LTSyntax fonts ..."
fi
if [ -e /Library/Fonts/LTSyntax\ Regular.ttf ];then
rm -rfv /Library/Fonts/LTSyntax\ Regular.ttf
fi
if [ -e /Library/Fonts/LTSyntax\ OsF\ Regular.ttf ];then
rm -rfv /Library/Fonts/LTSyntax\ OsF\ Regular.ttf
fi
if [ -e /Library/Fonts/LTSyntax\ Bold.ttf ];then
rm -rfv /Library/Fonts/LTSyntax\ Bold.ttf
fi
if [ -e /Library/Fonts/LTSyntax\ OsF\ Bold.ttf ];then
rm -rfv /Library/Fonts/LTSyntax\ OsF\ Bold.ttf
fi
if [ -e /Library/Fonts/LTSyntax\ Italic.ttf ];then
rm -rfv /Library/Fonts/LTSyntax\ Italic.ttf
fi
echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0