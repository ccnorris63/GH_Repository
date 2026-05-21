#!/bin/sh
exec >> "/Library/Logs/CompanyName Script.log" 2>&1

date=`date "+%A %m/%d/%Y"`
echo "********** $0" `date "+%A %m/%d/%Y %H:%M:%S"`" **********"
echo ""
echo "Set service order, disable PAN, DUN, & Bridge..."
sudo networksetup -setnetworkserviceenabled "Bluetooth PAN" OFF
sudo networksetup -setnetworkserviceenabled "Thunderbolt Bridge" OFF
echo ""
echo "Current Network Location and service order"
sudo networksetup -getcurrentlocation
sudo networksetup -listnetworkserviceorder

#sudo networksetup -ordernetworkservices "Ethernet 1" "Ethernet 2" "Thunderbolt Ethernet" "AX88179 USB 3.0 to Gigabit Ethernet" "Wi-Fi" "Bluetooth PAN" "Thunderbolt Bridge"

#echo ""
#echo "Create Wired location, set service order, disable all but Ethernet, and list results:"
#sudo networksetup -createlocation Wired populate
#sudo networksetup -switchtolocation Wired
#sudo networksetup -ordernetworkservices "Ethernet 1" "Ethernet 2" "Wi-Fi" "Bluetooth PAN" "Thunderbolt Bridge"
#sudo networksetup -setnetworkserviceenabled "Bluetooth PAN" OFF
#sudo networksetup -setnetworkserviceenabled "Thunderbolt Bridge" OFF
#sudo networksetup -setnetworkserviceenabled "Wi-Fi" OFF

#echo ""
#echo "Create Wireless location, set service order, disable all but Wi-Fi, and list results:"
#sudo networksetup -createlocation Wireless populate
#sudo networksetup -switchtolocation Wireless
#sudo networksetup -ordernetworkservices "Ethernet 1" "Ethernet 2" "Wi-Fi" "Bluetooth PAN" "Thunderbolt Bridge"
#sudo networksetup -setnetworkserviceenabled "Bluetooth PAN" OFF
#sudo networksetup -setnetworkserviceenabled "Thunderbolt Bridge" OFF
#sudo networksetup -setnetworkserviceenabled "Ethernet 1" OFF
#sudo networksetup -setnetworkserviceenabled "Ethernet 2" OFF

#echo ""
#echo "Make Automatic the current location, then list all locations:"
#sudo networksetup -switchtolocation Automatic
#sudo networksetup -listlocations

echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M:%S"`" **********"

exit 0
