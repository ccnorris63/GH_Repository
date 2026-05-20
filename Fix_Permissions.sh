#!/bin/sh
exec >> "/Library/Logs/CompanyName Script.log" 2>&1

echo " "
echo "*********************************** $0" `date "+%A %m/%d/%Y %H:%M"`" *********************************"
echo " "

# Determines the OS, then runs the proper commands to repair permissions

# variables & directories
DATE=`date "+%A %m/%d/%Y %H:%M"`
OS=`sw_vers -productVersion`

case `sw_vers -productVersion | awk -F . '{print $2}'` in 
	5) FixPerm="diskutil repairPermissions /" ;;      
	6) FixPerm="diskutil repairPermissions /" ;;  
	7) FixPerm="diskutil repairPermissions /" ;; 
	8) FixPerm="diskutil repairPermissions /" ;;
	9) FixPerm="diskutil repairPermissions /" ;;
	10) FixPerm="diskutil repairPermissions /" ;;
	11) FixPerm="/usr/libexec/repair_packages --repair --standard-pkgs --volume /" ;;
	*) echo "Unsupported client OS"; exit 1 ;;
esac
echo ""
echo "This Mac is running OSX:" $OS
echo ""
"${FixPerm}"

echo " "
echo "*********************************** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" *********************************"
echo " "

exit 0