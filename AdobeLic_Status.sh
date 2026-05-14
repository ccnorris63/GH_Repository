#!/bin/sh
touch /Library/CompanyName/ZipLogs/AdobeLic_Status.txt
exec >> "/Library/CompanyName/ZipLogs/AdobeLic_Status.txt" 2>&1

# Last updated February 27, 2017, Chris Norris
DATE=`date +"%m-%d-%Y_%H%M"`
ADMINRDATE=`date +"%m-%d-%Y"`
CPUNAME=`scutil --get ComputerName`
# ADMINEMAIL=(username1 username2 username3)
ADMINEMAIL=(username1)

printf "@*@*@*@*@* $0" `date "+%A %m/%d/%Y %H:%M"`" @*@*@*@*@*"'\n'

printf '\n'
printf "Contents of /Library/Application\ Support/regid.1986-12.com.adobe/:"'\n'
ls -@ /Library/Application\ Support/regid.1986-12.com.adobe/

printf '\n'
printf "Contents of /Library/Application Support/Adobe/SLCache/SLConfigs:"'\n'
ls -@ /Library/Application\ Support/Adobe/SLCache/SLConfigs

printf '\n'
printf "$CPUNAME Adobe LEIDs: "'\n'
for i in /Library/Application\ Support/regid.1986-12.com.adobe/*
do
	SWIDFILE=`basename "${i}" | cut -d } -f2`
    if [[ -e "${i}" ]]
    then
        printf "${SWIDFILE}: "
    	cat "${i}" | grep "swid:activation_status" | cut -d ">" -f2 | cut -d "<" -f1
    else
    	printf "Not Found: ${i}"'\n'
    fi
done
printf '\n'   
printf "@*@*@*@*@* $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" @*@*@*@*@*"

#sleep 3
#for i in ${ADMINEMAIL[@]}
#do
#    mail -s "Adobe License Status from $CPUNAME on $ADMINRDATE" $i@CompanyName.com </Library/CompanyName/ZipLogs/AdobeLic_Status.txt
#done

exit $?
