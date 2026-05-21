#!/bin/bash
# exec >> "/Library/Logs/CompanyName Script.log" 2>&1
# Last modified March 07, 2019, Chris Norris

# Establish Variables
DateCollect=$(date +"%m%d%Y")
EthPort=$(/usr/sbin/networksetup -listallhardwareports | grep -A1 Ethernet | grep Device | awk '{print $2}')
AdptPort=$(/usr/sbin/networksetup -listallhardwareports | grep -A1 Belkin | grep Device | awk '{print $2}')
WFPort=$(/usr/sbin/networksetup -listallhardwareports | grep -A1 Wi-Fi | grep Device | awk '{print $2}')
WFStat=`basename $(ifconfig $WFPort | grep status | cut -d ":" -f2)`

# Set default values
curr_eth_status="0"
curr_wf_status="0"
wf_power=$(/usr/sbin/networksetup -getairportpower en0 | awk '{print $4}')

if [ "$WFStat" == "active" ]; then
    echo "Wi-Fi $WFPort status: $WFStat"
    echo "airport power is $wf_power"
    echo "Setting curr_wf_status to 1 (ON)"
    curr_wf_status="1"
fi

for i in ${EthPort[@]}
    do
    EthStat=`basename $(ifconfig $i | grep status | cut -d ":" -f2)`
    if [ "$EthStat" == "active" ]; then
        echo "Ethernet $i status: $EthStat"
        echo "Setting curr_eth_status to 1 (ON)"
        curr_eth_status="1"
    fi
    done

for i in ${AdptPort[@]}
    do
    AdptStat=`basename $(ifconfig $i | grep status | cut -d ":" -f2)`
    if [ "$AdptStat" == "active" ]; then
        echo "Ethernet $i status: $AdptStat"
        echo "Setting curr_eth_status to 1 (ON)"
        curr_eth_status="1"
    fi
    done

if [ $curr_wf_status == "1" ] && [ $curr_eth_status == "1" ]; then
echo "********** $0 " `date "+%A %m/%d/%Y %H:%M:%S"` " **********"
echo ""
echo "!!! Ethernet connection found; CompanyName does not allow Dual Connections for security reseasons, Turning off Wireless !!!"
/usr/sbin/networksetup -setairportpower $WFPort off

# Use applescript to display a dialog indicating wireless is being turned off
osascript -e 'display dialog "CompanyName Digital does not allow dual network connections. Turning off your Wireless for now." buttons ("Ok") default button "Ok" with title "Simultaneous Ethernet and Wireless connections found!"'

echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M:%S"` " **********"
fi

exit 0
