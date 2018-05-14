#!/bin/bash
#
# Initial Configuration complete check - JAMF EA
#
# Written by Johan McGwire - Yohan @ MacAdmins Slack - Johan@McGwire.tech

if [ -f "/Library/InitialConfiguration/.InitialConfigurationComplete" ]; then
	echo "<result>true</result>"
else
	echo "<result>false</result>"
fi

exit