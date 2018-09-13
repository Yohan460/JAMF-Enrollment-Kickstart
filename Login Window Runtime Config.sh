#!/bin/bash
#
# Author: Johan McGwire - Yohan @ Macadmins Slack - Johan@McGwire.tech
#
# Description: This writes out a Initial Configuration skip user check receipt

# Creating directory and writing receipt
mkdir /Library/InitialConfiguration
chmod 775 /Library/InitialConfiguration
touch /Library/InitialConfiguration/.InitalConfigSkipCheckUser

# Exiting and returning the policy call code
exit $?