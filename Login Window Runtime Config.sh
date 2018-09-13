#!/bin/bash
#
# Author: Johan McGwire - Yohan @ Macadmins Slack - Johan@McGwire.tech
#
# Description: This writes out a Initial Configuration skip user check receipt

# Writing out a  receipt
touch /Library/InitialConfiguration/.InitalConfigSkipCheckUser

# Exiting and returning the policy call code
exit $?