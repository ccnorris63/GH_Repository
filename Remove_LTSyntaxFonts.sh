#!/bin/sh
exec >> "/Library/Logs/Getty Installations.log" 2>&1 

# Last modified May 30, 2016, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
if [ -e /Library/Fonts/LTSyntax\ Regular.ttf ];then
echo "Location: /Library/Fonts/Getty folder"
echo "Removing old /Library/Fonts/Getty/LTSyntax fonts ..."
fi
if [ -e /Library/Fonts/Getty/LTSyntax\ Regular.ttf ];then
rm -rfv /Library/Fonts/Getty/LTSyntax\ Regular.ttf
fi
if [ -e /Library/Fonts/Getty/LTSyntax\ OsF\ Regular.ttf ];then
rm -rfv /Library/Fonts/Getty/LTSyntax\ OsF\ Regular.ttf
fi
if [ -e /Library/Fonts/Getty/LTSyntax\ Bold.ttf ];then
rm -rfv /Library/Fonts/Getty/LTSyntax\ Bold.ttf
fi
if [ -e /Library/Fonts/Getty/LTSyntax\ OsF\ Bold.ttf ];then
rm -rfv /Library/Fonts/Getty/LTSyntax\ OsF\ Bold.ttf
fi
if [ -e /Library/Fonts/Getty/LTSyntax\ Italic.ttf ];then
rm -rfv /Library/Fonts/Getty/LTSyntax\ Italic.ttf
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