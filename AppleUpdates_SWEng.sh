#!/bin/bash
exec >> "/Library/Logs/CompanyName Script.log" 2>&1

/usr/bin/osascript -e '
tell application "System Events"
	activate
    set thisday to do shell script "date +%m/%d/%Y"
    set updatehistory to do shell script "softwareupdate --history | cut -c -42,62-72"
	display dialog "Good morning! Software Update was run today, " & thisday & "\
    The following are the updates installed and when: \
    \
	" & updatehistory & "\
    \
    Your system may need to be rebooted if any Security or OS patch was applied..." buttons ("Ok") default button "Ok" with title "Apple Software Updates"
end tell'
