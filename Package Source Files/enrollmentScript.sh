#!/bin/bash
#
# Author: Johan McGwire - Yohan @ Macadmins Slack - Johan@McGwire.tech
#
# Description: This script is used to reapeatdly call a policy trigger until removed and unloaded. 

# Establishing the logging variables
LOGFOLDER="/var/log"
LOGFILE="${LOGFOLDER}/Initial_Configuration_Policy_Call.log"

if [ ! -d "$LOGFOLDER" ];
then
	/bin/mkdir "$LOGFOLDER"
fi

if [ ! -f "$LOGFILE" ];
then
	/usr/bin/touch ${LOGFILE}
fi

# Establishing the logging functionality
function logme()
{
# Check to see if function has been called correctly
	if [ -z "$1" ]; then
		/bin/echo "$(date '+%F %T') - logme function call error: no text passed to function! Please recheck code!"
		/bin/echo "$(date '+%F %T') - logme function call error: no text passed to function! Please recheck code!" >> ${LOGFILE}		
		exit 1
	fi

# Log the passed details
	/bin/echo "$(date '+%F %T') - $1"
	/bin/echo "$(date '+%F %T') - $1" >> ${LOGFILE}
}

# Initializing log
logme "======== Starting Configuration Policy Script ========"

if [[ -f "/Library/InitialConfiguration/.InitalConfigSkipCheckUser" ]]; then

	logme "Login Window runtime detected, skipping user check"

else

	# Checking for the currently logged in user
	while [[ "$(/bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }')" == '_mbsetupuser' || "$(/bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }')" == 'root' ]]; do

		# Logging the user lookup
		logme "User Logged in Check failed, waiting 10 seconds: $(/bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }')"
		
		# Waiting
		sleep 10
	done

	logme "Logged in user: $(/bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }')"

fi

logme "Running as: $(whoami)"

# Checking for an internet connection
returnCode=1
while [[ "${returnCode}" -ne "0" ]]; do

	# Loading google.com
    echo -e "GET http://google.com HTTP/1.0\n\n" | nc google.com 80 > /dev/null 2>&1
    returnCode=$?

    # Waiting
    if [[ "${returnCode}" -ne "0" ]]; then

    	# Logging the user lookup
    	logme "Internet check failed, waiting 10 seconds"

    	# Waiting
   	sleep 10

    fi
done

logme "Internet connection verified"

# Sleeping to ensure correct policy call
sleep 5

if [[ ! -f "/Library/InitialConfiguration/.InitialConfigurationComplete" ]]; then

	# Running the policy
	logme "Calling the jamf policy with an InitialConfig trigger"
	caffeinate -disu bash -c '/usr/local/bin/jamf policy -trigger InitialConfig'
	returnCode=$?

	if [[ "${returnCode}" == "0" ]]; then
		logme "Policy call successful"
	else
		logme "FAILED policy call"
	fi
else

	logme "Configuration Receipt present, Not calling setup policy"
fi

# Closing log
logme "======== Finished Configuration Policy Script ========"

# Exiting and returning the policy call code (never actually reaches this point due to stoping after the reload)
exit $returnCode
