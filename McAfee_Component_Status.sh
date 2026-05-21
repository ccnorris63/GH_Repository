#!/bin/sh
exec >> "/Library/Logs/CompanyName Script.log" 2>&1

echo " "
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "

echo "Status of McAfee Agent..."
sudo /Library/McAfee/agent/scripts/ma status
echo "McAfee Agent information..."
sudo /Library/McAfee/agent/bin/cmdagent -i

echo "Status of McAfee Endpoint Protection For Mac..."
sudo /usr/local/McAfee/AntiMalware/VSControl status
echo ""
echo "Status of EPM General (Endpoint Protection For Mac)..."
sudo /usr/local/McAfee/fmp/bin/fmp status
echo ""
echo "Status of Application Protection..."
sudo /usr/local/McAfee/AppProtection/bin/AppProtControl status
echo ""
echo "Status of Statefull Firewall (Host Intrusion Protection)..."
sudo /usr/local/McAfee/StatefulFirewall/bin/StatefullFirewallControl status

open /Library/Logs/Getty\ Script.log

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"
exit 0
