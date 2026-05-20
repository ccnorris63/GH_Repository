#!/bin/bash
exec >> "/Library/Logs/CompanyName Script.log" 2>&1
# Last modified June 13, 2018, Chris Norris
/bin/echo ""
/bin/echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
/bin/echo ""
if [ -f "/private/etc/nsmb.conf" ]
then
/bin/echo "Found: /private/etc/nsmb.conf..."
/bin/echo "Current settings in nsmb.conf:"
cat /private/etc/nsmb.conf
/bin/echo ""
/bin/echo "Adding new settings..."
/bin/echo "signing_required=yes
protocol_vers_map=6
minauth=ntlmv2
signing_req_vers=6
port445=no_netbios" >> /private/etc/nsmb.conf
else
/bin/echo "Creating /private/etc/nsmb.conf..."
touch /private/etc/nsmb.conf
/bin/echo "[default]
signing_required=yes
protocol_vers_map=6
minauth=ntlmv2
signing_req_vers=6
port445=no_netbios" > /private/etc/nsmb.conf
/bin/echo "New settings in nsmb.conf:"
cat /private/etc/nsmb.conf
fi
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"
exit 0