#!/bin/bash
# This script will download the munkiOnDemand repo into
# the /tmp directory and then move the plist into the user's space.
# Inspired by Joshua D. Miller's GarageBand Loops script:
# https://joshua-d-miller.com/blog/2018/self-service-for-garageband-loops/
# Tobias Morrison - tobias@globalmacit.com
# GlobalMac IT
# Last Updated - 06-28-2019

## VARIABLES ##
# CHANGE THIS
customPlist="com.apple.print.custompresets.forprinter.CHANGE_ME.plist"

# LEAVE THIS ALONE
currentUser=$(python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')

# Download the Zip file of the GitHub Repository
/usr/bin/curl -o /tmp/munkiOnDemand.zip -LO https://github.com/globalmacit/munkiOnDemand/archive/master.zip

# Extract it in our Temp Folder
/usr/bin/unzip -q /tmp/munkiOnDemand.zip -d /tmp

# Move the plist to the local user's space
/bin/mv /tmp/munkiOnDemand-master/"$customPlist" /Users/"$currentUser"/Library/Preferences/"$customPlist"

# Cleanup
/usr/bin/killall cfprefsd
/bin/rm -rf /tmp/munkiOnDemand-master
/bin/rm -f /tmp/munkiOnDemand.zip