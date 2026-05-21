#!/bin/sh
## postinstall
exec >> "/Library/Logs/CompanyName Installations.log" 2>&1 
date=`date "+%A %m/%d/%Y"`
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "

echo "Prompt the user for the department installation set they want"
/usr/bin/osascript <<-EOF
set appsetlist to {"none", "design", "gri pubs", "sth pubs", "imaging"}
set deptinstall to item 1 of (choose from list appsetlist with prompt "What set of department applications do you want to install?" default items "none")
if deptinstall is false then
	error number -128 (* user cancelled *)
else if the deptinstall is "none" then
	display alert "You chose to not install any applications."
else if the deptinstall is "design" then
	display alert "You chose to install Art Directors Toolkit, Adobe Creative Cloud, Default Folder X, Sketch, SketchUp Pro, Stuffit Deluxe, and FontExplorerX Pro 6"
	do shell script "/usr/local/jamf/bin/jamf policy -event CCApp"
	do shell script "/usr/local/jamf/bin/jamf policy -event CCApp"
	do shell script "/usr/local/jamf/bin/jamf policy -event DefaultFolder"
	do shell script "/usr/local/jamf/bin/jamf policy -event Sketch"
	do shell script "/usr/local/jamf/bin/jamf policy -event SketchUp2018"
	do shell script "/usr/local/jamf/bin/jamf policy -event Stuffit"
	do shell script "/usr/local/jamf/bin/jamf policy -event FEXPro6"
else if the deptinstall is "gri pubs" then
	display alert "You chose to install Expression Media v.2.0.2, and Merriam-Webster Dictionary, Editors Toolkit Plus 2018"
	do shell script "/usr/local/jamf/bin/jamf policy -event ExpressMedia"
	do shell script "/usr/local/jamf/bin/jamf policy -event Webster"
    do shell script "/usr/local/jamf/bin/jamf policy -event EditorTk"
else if the deptinstall is "sth pubs" then
	display alert "You chose to install Adobe Creative Cloud, FontExplorerX Pro 6, and Fetch"
	do shell script "/usr/local/jamf/bin/jamf policy -event CCApp"
	do shell script "/usr/local/jamf/bin/jamf policy -event FEXPro6"
	do shell script "/usr/local/jamf/bin/jamf policy -event Fetch"
else if the deptinstall is "imaging" then
	display alert "You chose to install Adobe Creative Cloud, CaptureOne, and HeliconFocus"
	do shell script "/usr/local/jamf/bin/jamf policy -event CCApp"
	do shell script "/usr/local/jamf/bin/jamf policy -event CaptureOne"
	do shell script "/usr/local/jamf/bin/jamf policy -event Helicon"
	end if
EOF

sleep 5

echo "Prompt user to install FileMaker Pro"
/usr/bin/osascript <<-EOF
display dialog "Do you want to install FileMaker Pro" buttons {"No", "Yes"} default button 1 with title "FileMaker Pro Installation"
if button returned of result = "No" then
	display alert "Not installing FileMaker Pro"
else if button returned of result = "Yes" then
	do shell script "/usr/local/jamf/bin/jamf policy -event FMP16"
end if
EOF

echo "display a dialog indicating the end of the departmental installations"
/usr/bin/osascript -e '
tell application "Finder"
	activate
    display dialog "The departmental installations have completed." buttons ("Ok") default button "Ok" with title "Department Installs Complete"
end tell'


echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
exit 0