#!/bin/bash
# wait 5 seconds to give user time to login
sleep 5
# Variables
LoggedUser="$(stat -f "%Su" /dev/console)"
PlistFile="com.apple.print.custompresets.forprinter.PRINTER_NAME.plist"
function createPlistFile {
cat <<'EOFPLIST' > "$PlistFile"

[ENTER PLIST INFORMATION AND KEYS]

EOFPLIST
# Convert XML to Binary
plutil -convert binary1 "$PlistFile"
}
#DO NOT EDIT ANYTHING BELOW THIS LINE!!!
# check if root detected. script stops if true
if [ "$LoggedUser" == "root" ]
then
 echo "Root User Detected. Operation Ended."
else
 echo "Running as user: $LoggedUser"
fi
# check if file is present; if true, put in trash and recreate. Otherwise, creates file.
if [ -f "/Users/$LoggedUser/Library/Preferences/$PlistFile" ]
then
 echo "Replacing $PlistFile"
 cd "/Users/$LoggedUser/Library/Preferences/"
 mv "/Users/$LoggedUser/Library/Preferences/$PlistFile" "/Users/$LoggedUser/.Trash/$PlistFile"
 createPlistFile
else
 echo "Creating $PlistFile"
 cd "/Users/$LoggedUser/Library/Preferences/"
 createPlistFile
fi