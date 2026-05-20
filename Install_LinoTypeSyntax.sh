#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1

# Updated script February 21 2017, Chris Norris
DATE=`date "+%A %m/%d/%Y %H:%M"`
INSTALLDATE=`date +"%m-%d-%Y"`
CPUNAME=`scutil --get ComputerName`
DSCVEMAIL=(cnorris)

echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
i="0"
#until [ -e /Library/Fonts/LTSCom.zip ]; do 
#	while [ $i -lt 3 ]
#	do
#		sleep 3
#		i=$[$i+1]
#	done
#done
echo "Installing LinotypeSyntaxCom (licensed) fonts..."
xattr -d -r /Library/Fonts/LTSCom.zip
# open /Library/Fonts/LTSCom.zip
sleep 5
mv -fv /Library/Fonts/LTSCom/LinotypeSyntaxCom* /Library/Fonts
chown -R root:wheel /Library/Fonts/LinotypeSyntaxCom*
chmod -R 644 /Library/Fonts/LinotypeSyntaxCom*

echo "Checking files have been installed..."
INSTALLCHK=0
if [ -e /Library/Fonts/LinotypeSyntaxCom-Bold.ttf ];then
    echo "LinotypeSyntaxCom-Bold.ttf has been installed successfully"
else
    echo "LinotypeSyntaxCom-Bold.ttf was not installed!!!"
    INSTALLCHK=$INSTALLCHK+1
fi

if [ -e /Library/Fonts/LinotypeSyntaxCom-Italic.ttf ];then
    echo "LinotypeSyntaxCom-Italic.ttf has been installed successfully"
else
    echo "LinotypeSyntaxCom-Italic.ttf was not installed!!!"
    INSTALLCHK=$INSTALLCHK+2
fi

if [ -e /Library/Fonts/LinotypeSyntaxCom-Regular.ttf ];then
    echo "LinotypeSyntaxCom-Regular.ttf has been installed successfully"
else
    echo "LinotypeSyntaxCom-Regular.ttf was not installed!!!"
    INSTALLCHK=$INSTALLCHK+4
fi
echo "INSTALLCHK = $INSTALLCHK"

echo "Cleaning up..."
rm -rfv /Library/Fonts/LTSCom
if [ INSTALLCHK = "0" ];then
    rm -rfv /Library/Fonts/LTSCom.zip
fi

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit 0