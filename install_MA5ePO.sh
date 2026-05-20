#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1

DATE=`date "+%A %m/%d/%Y %H:%M"`
echo " "
echo "*********************************** $0" `date "+%A %m/%d/%Y %H:%M"`" *********************************"
echo " "
echo "Setting permissions for VSePO components..."
sudo chmod 755 /usr/local/VSePO/*

if [ -e /Library/McAfee/agent/bin/cmdagent ];then
    echo "Updating the McAfee Agent..."
    sudo /usr/local/VSePO/install.sh -u
else
    echo "Installing the McAfee Agent..."
    sudo /usr/local/VSePO/install.sh -i
fi
sleep 5
echo "Setting permissions for the McAfee binaries..."
sudo chown root:wheel /Library/McAfee/agent/bin/*
sudo chown mfe /Library/McAfee/agent/bin/macmnsvc
sudo chmod +x /Library/McAfee/agent/bin/*

echo "Making sure LaunchDaemon components are loaded..."
launchctl load -w /Library/LaunchDaemons/com.mcafee.agent.ma.plist
launchctl load -w /Library/LaunchDaemons/com.mcafee.agent.macmn.plist
launchctl load -w /Library/LaunchDaemons/com.mcafee.agent.macompat.plist

echo "Directing the McAfee Agent to the server..."
sudo /Library/McAfee/agent/bin/maconfig -provision -managed -dir /usr/local/VSePO
sleep 5

echo "Directing the McAfee Agent to check for new policies..."
sudo /Library/McAfee/agent/bin/cmdagent -c -p
echo ""
echo "*********************************** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" *********************************"
exit 0
