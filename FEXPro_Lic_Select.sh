#!/bin/sh
exec >> "/Library/Logs/Getty Installations.log" 2>&1

# Last modified November 20, 2017, Chris Norris
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "

# == variables ==
DateCollect=$(date +"%m%d%Y")
HstName=$(scutil --get HostName)
LICCOM="/private/tmp/COMFEXProLicense"
LICMUS="/private/tmp/MUSFEXProLicense"
LICGRI="/private/tmp/GRIFEXProLicense"
LICITS="/private/tmp/MUSFEXProLicense"
OS=`sw_vers -productVersion | cut -d . -f2`

IPAddr=$(system_profiler SPNetworkDataType | grep -m1 "IPv4 Addresses: 153.10" | cut -d ":" -f2 | cut -c 2-)
echo "What is the User's IP Adress? $IPAddr"

SubNet=$(system_profiler SPNetworkDataType | grep -m1 "IPv4 Addresses: 153.10" | cut -d ":" -f2 | cut -d "." -f3)
echo "This system is in the $SubNet subnet"

case $SubNet in
5[5-7])
    SELECTPATH=$LICMUS
    ;;
64)
    SELECTPATH=$LICMUS
    ;;
73)
    SELECTPATH=$LICMUS
    ;;
12[1-7])
    SELECTPATH=$LICMUS
    ;;
104)
    SELECTPATH=$LICCOM
    ;;
102)
    SELECTPATH=$LICITS
    ;;
136)
    SELECTPATH=$LICGRI
    ;;
202)
    SELECTPATH=$LICITS
    ;;
222)
    SELECTPATH=$LICITS
    ;;
esac

for USER_HOME in /Users/*
    do
        USER_UID=`basename "${USER_HOME}"`
        if [ ! "${USER_UID}" = "Shared" ]
        then
            echo "Copying Client License from $LICBASEPATH/$SELECTPATH..."
            if [ ! -d /Users/"${USER_UID}"/Library/Application\ Support/Linotype/FontExplorer\ X ]
            then
            mkdir -pv /Users/"${USER_UID}"/Library/Application\ Support/Linotype/FontExplorer\ X
            fi
            cp -fv "${SELECTPATH}"/ClientLicense.fcl /Users/"${USER_UID}"/Library/Application\ Support/Linotype/FontExplorer\ X
            chown -R "${USER_UID}" /Users/"${USER_UID}"/Library/Application\ Support
            xattr -d -r com.apple.quarantine /Applications/FontExplorer\ X\ Pro.app
        fi
    done
echo ""
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
exit 0