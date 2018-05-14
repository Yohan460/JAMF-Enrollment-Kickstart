#!/bin/bash
#
# Author: Johan McGwire - Yohan @ Macadmins Slack - Johan@McGwire.tech
#
# Description: This script removes the Initial Configuration launchagent from the box

launchctl unload /Library/LaunchDaemons/com.JAMF.InitialConfig.plist
rm -f /Library/LaunchDaemons/com.JAMF.InitialConfig.plist

exit 0