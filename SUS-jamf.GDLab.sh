#!/bin/sh
exec >> "/Library/Logs/Getty Script.log" 2>&1

DATE=`date "+%A %m/%d/%Y %H:%M"`
echo " "
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "

# script switches getty colleagues to the "LabTesters" reposado branch
# checks for client OS and applies correct server/catalog combo

# ---------------------------------------------------------
# variables & directories
# variables use ticks (`), directories quotes (")
# ---------------------------------------------------------
OS=`sw_vers -productVersion`

case `sw_vers -productVersion | awk -F . '{print $2}'` in 
	10) URL="http://jamf.getty.edu/content/catalogs/others/index-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1_GDLab.sucatalog" ;;
	11) URL="http://jamf.getty.edu/content/catalogs/others/index-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1_GDLab.sucatalog" ;;
	12) URL="http://jamf.getty.edu/content/catalogs/others/index-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1_GDLab.sucatalog" ;;
	13) URL="http://jamf.getty.edu/content/catalogs/others/index-10.13-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1_GDLab.sucatalog" ;;
    14) URL="http://jamf.getty.edu/content/catalogs/others/index-10.14-10.13-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1_GDLab.sucatalog" ;;
    15) URL="http://jamf.getty.edu/content/catalogs/others/index-10.15-10.14-10.13-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1_GDLab.sucatalog" ;;
	*) echo "Unsupported client OS"; exit 1 ;;
esac

defaults write /Library/Preferences/com.apple.SoftwareUpdate CatalogURL "${URL}"

echo "This Mac is running OSX:" $OS
echo "Confirming... The Software Update Server assigned to this Mac for the LabTesters group is:"
defaults read /Library/Preferences/com.apple.SoftwareUpdate CatalogURL

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "

exit 0