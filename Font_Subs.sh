#!/bin/sh
#output to log
exec >> "/Library/Logs/CompnayName Script.log" 2>&1 

# Last modified October 10, 2018, Paul Mullins
echo " "
echo "********** $0" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "

for USER_HOME in /Users/*
  do
    USER_UID=`basename "${USER_HOME}"`
    if [ ! "${USER_UID}" = "Shared" ] 
    then 
    if [ -d "/Users/"${USER_UID}"/Library/Application Support/Microsoft/Office/Preferences/Office 2011" ]
    then
    echo "The /Library/Application Support/Microsoft/Office/Preferences/Office 2011 was found."
    sed -i '' -e $'s/; PostScript names, and TrueType names into account./; PostScript names, and TrueType names into account.\\\rLTSyntax Black=Linotype Syntax Com Bold\\\r\LTSyntax BlackItalic=Linotype Syntax Com Bold\r\LTSyntax Bold=Linotype Syntax Com Bold\\\r\LTSyntax Heavy=Linotype Syntax Com Bold\\\r\LTSyntax HeavyItalic=Linotype Syntax Com Bold\\\r\LTSyntax Italic=Linotype Syntax Com Italic\\\r\LTSyntax Light=Linotype Syntax Com Regular\\\r\LTSyntax Medium=Linotype Syntax Com Regular\\\r\LTSyntax MediumItalic=Linotype Syntax Com Regular\\\r\LTSyntax OsF Black=Linotype Syntax Com Bold\\\r\LTSyntax OsF BlackItalic=Linotype Syntax Com Bold\\\r\LTSyntax OsF Bold=Linotype Syntax Com Bold\\\r\LTSyntax OsF Heavy=Linotype Syntax Com Bold\\\r\LTSyntax OsF Light=Linotype Syntax Com Regular\\\r\LTSyntax OsF Medium=Linotype Syntax Com Regular\\\r\LTSyntax OsF Regular=Linotype Syntax Com Regular\\\r\LTSyntax Regular=Linotype Syntax Com Regular\\\r\LTSyntax SC Regular=Linotype Syntax Com Regular/' /Users/"${USER_UID}"/Library/Application\ Support/Microsoft/Office/Preferences/Office\ 2011/Word\ Font\ Substitutes
    fi
    if [ -d "/Users/"${USER_UID}"/Library/Containers/com.microsoft.Word/Data/Library/Preferences" ]
    then
    echo "The /Library/Containers/com.microsoft.Word/Data/Library/Preferences was found."
    sed -i '' -e $'s/; PostScript names, and TrueType names into account./; PostScript names, and TrueType names into account.\\\rLTSyntax Black=Linotype Syntax Com Bold\\\r\LTSyntax BlackItalic=Linotype Syntax Com Bold\r\LTSyntax Bold=Linotype Syntax Com Bold\\\r\LTSyntax Heavy=Linotype Syntax Com Bold\\\r\LTSyntax HeavyItalic=Linotype Syntax Com Bold\\\r\LTSyntax Italic=Linotype Syntax Com Italic\\\r\LTSyntax Light=Linotype Syntax Com Regular\\\r\LTSyntax Medium=Linotype Syntax Com Regular\\\r\LTSyntax MediumItalic=Linotype Syntax Com Regular\\\r\LTSyntax OsF Black=Linotype Syntax Com Bold\\\r\LTSyntax OsF BlackItalic=Linotype Syntax Com Bold\\\r\LTSyntax OsF Bold=Linotype Syntax Com Bold\\\r\LTSyntax OsF Heavy=Linotype Syntax Com Bold\\\r\LTSyntax OsF Light=Linotype Syntax Com Regular\\\r\LTSyntax OsF Medium=Linotype Syntax Com Regular\\\r\LTSyntax OsF Regular=Linotype Syntax Com Regular\\\r\LTSyntax Regular=Linotype Syntax Com Regular\\\r\LTSyntax SC Regular=Linotype Syntax Com Regular/' /Users/"${USER_UID}"/Library/Containers/com.microsoft.Word/Data/Library/Preferences/Word\ Font\ Substitutes
    fi
    fi
done

echo " "
echo "********** $0 Completed" `date "+%A %m/%d/%Y %H:%M"`" **********"
echo " "
exit 0