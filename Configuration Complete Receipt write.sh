#!/bin/bash
#
# Author: Johan McGwire - Yohan @ Macadmins Slack - Johan@McGwire.tech
#
# Description: This writes out a Initial Configuration complete receipt

# Writing out a configuration receipt
mkdir /Library/InitialConfiguration
touch /Library/InitialConfiguration/.InitialConfigurationComplete

# Exiting and returning the policy call code
exit $?
