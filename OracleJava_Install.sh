#!/bin/sh
exec >> "/Library/Logs/Getty Installations.log" 2>&1

DATE=`date "+%A %m/%d/%Y %H:%M"`
JUPD=212
echo " "
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo "********** Java v8.0 Update $JUPD Installation **********"
echo " "
# Variables
JAVAEXCPT=( "https://webconnect.getty.edu" "https://tfa.getty.edu" "http://javatester.org" )

for USER_HOME in /Users/*
  do
    USER_UID=`basename "${USER_HOME}"`
    if [ ! "${USER_UID}" = "Shared" ] 
    then 
    	if [ ! -e /Users/"${USER_UID}"/Library/Application\ Support/Oracle/Java/Deployment/security/exception.sites ] 
    	then
    		echo "No Oracle/Java/Deployment/security/exception.sites found."
    	else
    		mkdir -p /Users/"${USER_UID}"/Library/Application\ Support/Backup
    		mv -v /Users/"${USER_UID}"/Library/Application\ Support/Oracle/Java/Deployment/security/exception.sites /Users/"${USER_UID}"/Library/Application\ Support/Backup
    	fi
	fi
  done

echo "Mounting jre-8u$JUPD-macosx-x64.dmg..."
hdiutil attach -nobrowse /private/tmp/jre-8u$JUPD-macosx-x64.dmg
echo "List mounted volumes:"
ls -la /Volumes
echo ""
echo "Installing Java v8.0 Update $JUPD...."
if [ -e /Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin ] 
then
    rm -rfv /Library/Internet\ Plug-Ins/JavaAppletPlugin.save
    cp -rfv /Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin /Library/Internet\ Plug-Ins/JavaAppletPlugin.save
    rm -rfv /Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin
fi
installer -pkg /Volumes/Java\ 8\ Update\ $JUPD/Java\ 8\ Update\ $JUPD.app/Contents/Resources/JavaAppletPlugin.pkg -target /
echo "The current version of the /Library/Internet Plug-Ins/JavaAppletPlugin.plugin is: "
defaults read /Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin/Contents/Info CFBundleShortVersionString

for USER_HOME in /Users/*
  do
    USER_UID=`basename "${USER_HOME}"`
    if [ ! "${USER_UID}" = "Shared" ] 
    then 
    	if [ ! -e /Users/"${USER_UID}"/Library/Application\ Support/Backup/exception.sites ] 
    	then
    		echo "Create the /Users/"${USER_UID}"/Library/Application Support/Oracle/Java/Deployment/security path..."
    		mkdir -pv /Users/"${USER_UID}"/Library/Application\ Support/Oracle/Java/Deployment/security
    		echo "Creating exception.sites file ..."
		    touch /Users/"${USER_UID}"/Library/Application\ Support/Oracle/Java/Deployment/security/exception.sites
    	else
    	    mv -fv /Users/"${USER_UID}"/Library/Application\ Support/Backup/exception.sites /Users/"${USER_UID}"/Library/Application\ Support/Oracle/Java/Deployment/security 
    	fi
		echo "Patch exception.sites with our content, if it doesn't already have it."
		patch /Users/"${USER_UID}"/Library/Application\ Support/Oracle/Java/Deployment/security/exception.sites /private/tmp/SiteExcptions/changes.patch
		echo "Change owner and enable write permissions of exception.sites for current user..."
		chown -R "${USER_UID}" /Users/"${USER_UID}"/Library/Application\ Support/Oracle/Java
		chmod -R +w /Users/"${USER_UID}"/Library/Application\ Support/Oracle/Java
		echo "Dismounting Java 8 Update $JUPD..."
        umount -vf /Volumes/"Java 8 Update $JUPD"
        echo "Remaining mounted volumes..."
        ls -l /Volumes
	fi
  done
sleep 5
echo "Dismounting Java 8 Update $JUPD..."
sudo umount -vf /Volumes/"Java 8 Update $JUPD"
echo "Remaining mounted volumes..."
ls -l /Volumes
echo "Deleting jre-8u$JUPD-macosx-x64.dmg..."
rm -rfv /private/tmp/jre-8u$JUPD-macosx-x64.dmg
 
if (test $? = 0) then
	date "+%A %m/%d/%Y %H:%M:%S  Java v8.0 Update $JUPD Update was installed successfully."
else
	date "+%A %m/%d/%Y %H:%M:%S  Java v8.0 Update $JUPD installation failed."
fi
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"
exit $?