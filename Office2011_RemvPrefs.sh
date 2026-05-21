#!/bin/sh
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1
echo " "
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"

for USER_HOME in /Users/*
do
USER_UID=`basename "${USER_HOME}"`
if [ ! "${USER_UID}" = "Shared" ]
then
    echo “clearing /Users/"${USER_UID}"/Library/Application Support/Microsoft/Office/Caches:”
    rm -fv /Users/"${USER_UID}"/Library/Application Support/Microsoft/Office/Caches/com.microsoft.Excel
    rm -fv /Users/"${USER_UID}"/Library/Application Support/Microsoft/Office/Caches/com.microsoft.Word
    rm -fv /Users/"${USER_UID}"/Library/Application Support/Microsoft/Office/Caches/com.microsoft.Powerpoint
    rm -rfv /Users/"${USER_UID}"/Library/Application Support/Microsoft/Office/Caches//Microsoft

    echo “clearing /Users//Library/Application Support/Microsoft/Office/Preferences:”
    rm -fv /Users/"${USER_UID}"/Library/Application Support/Microsoft/Office/Preferences/com.microsoft.autoupdate.fba.debuglogging.plist
    rm -fv /Users/"${USER_UID}"/Library/Application Support/Microsoft/Office/Preferences/com.microsoft.autoupdate2.plist
    rm -fv /Users/"${USER_UID}"/Library/Application Support/Microsoft/Office/Preferences/com.microsoft.error_reporting.plist
    rm -fv /Users/"${USER_UID}"/Library/Application Support/Microsoft/Office/Preferences/com.microsoft.Excel.plist
    rm -fv /Users/"${USER_UID}"/Library/Application Support/Microsoft/Office/Preferences/com.microsoft.office.plist
    rm -fv /Users/"${USER_UID}"/Library/Application Support/Microsoft/Office/Preferences/com.microsoft.Powerpoint.plist
    rm -fv /Users/"${USER_UID}"/Library/Application Support/Microsoft/Office/Preferences/com.microsoft.visualbasic.plist
    rm -fv /Users/"${USER_UID}"/Library/Application Support/Microsoft/Office/Preferences/com.microsoft.Word.plist

    rm -fv /Users/"${USER_UID}"/Library/Application Support/Microsoft/Office/Preferences/com.microsoft.autoupdate.fba.debuglogging.plist.lockfile
    rm -fv /Users/"${USER_UID}"/Library/Application Support/Microsoft/Office/Preferences/com.microsoft.autoupdate2.plist.lockfile
    rm -fv /Users/"${USER_UID}"/Library/Application Support/Microsoft/Office/Preferences/com.microsoft.error_reporting.plist.lockfile
    rm -fv /Users/"${USER_UID}"/Library/Application Support/Microsoft/Office/Preferences/com.microsoft.Excel.plist.lockfile
    rm -fv /Users/"${USER_UID}"/Library/Application Support/Microsoft/Office/Preferences/com.microsoft.office.plist.lockfile
    rm -fv /Users/"${USER_UID}"/Library/Application Support/Microsoft/Office/Preferences/com.microsoft.Powerpoint.plist.lockfile
    rm -fv /Users/"${USER_UID}"/Library/Application Support/Microsoft/Office/Preferences/com.microsoft.visualbasic.plist.lockfile
    rm -fv /Users/"${USER_UID}"/Library/Application Support/Microsoft/Office/Preferences/com.microsoft.Word.plist.lockfile

    rm -rfv /Users/"${USER_UID}"/Library/Application Support/Microsoft/Office/Preferences//Microsoft/*
fi
done

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"

exit $?