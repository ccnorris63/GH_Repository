#!/bin/bash
exec >> "/Library/Logs/Getty Script.log" 2>&1
# Last modified August 26, 2019, Chris Norris

# Establish Variables
DateCollect=$(date +"%m%d%Y")
#NetwrkSvcs=$(networksetup -listallnetworkservices | sed "1 d")

echo "********** $0 " `date "+%A %m/%d/%Y %H:%M:%S"` " **********"
echo "Active network Services:"
    networksetup -listallnetworkservices | sed "1 d" | grep -v \*
echo ""

#for ((i = 0; i < ${#NetwrkSvcs[@]}; i++))
#do
#    networksetup -setv6off "${NetwrkSvcs[$i]}"
#done

networksetup -listallnetworkservices | sed "1 d" | while read NETSRVC
do
 echo "Disabling IPv6 on $NETSRVC..."
 networksetup -setv6off "$NETSRVC"
 networksetup -getinfo "$NETSRVC" | grep IPv6
 echo ""
done

echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M:%S"` " **********"
exit 0