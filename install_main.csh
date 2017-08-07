#!/bin/sh
export INSTALL_HOME=`pwd`
DATE=`date +%m-%d-%H-%M`
export INSTALL_LOG="$INSTALL_HOME/nagios_log/nagios_install_log_$DATE"
export INSTALL_CFGS="$INSTALL_HOME/cfgs"
export INSTALL_SCRIPTS="$INSTALL_HOME/scripts"
echo
echo Logging Installation at $INSTALL_LOG
sleep 3
echo
echo '#######################################'
echo '# TIME TO INSTALL THE USERS'
echo '#######################################'
echo
read -n 1 -s -r -p "Press any key to continue or Ctrl + C to quit"
echo
$INSTALL_SCRIPTS/install_users.sh
echo
echo '#######################################'
echo '# TIME TO INSTALL THE TOOLS'
echo '#######################################'
echo
read -n 1 -s -r -p "Press any key to continue or Ctrl + C to quit"
echo
$INSTALL_SCRIPTS/install_tools.sh
echo
echo '#######################################'
echo '# TIME TO INSTALL NAGIOS / NRPE'
echo '#######################################'
echo
read -p "Are you installing the main Nagios server or a NRPE Client? Press 'n' for Nagios or 'c' for Client" -n 1 REPLY
if [[ $REPLY =~ ^[Nn]$ ]]; then
	echo
	read -n 1 -s -r -p "OK, lets start installing Nagios.  Press any key to continue or Ctrl + C to quit"
	$INSTALL_SCRIPTS/install_nagios.sh
elif [[ $REPLY =~ ^[Cc]$ ]]; then
	echo
	read -n 1 -s -r -p "OK, lets start installing the NRPE Client.  Press any key to continue or Ctrl + C to quit"
	$INSTALL_SCRIPTS/install_nrpe.sh
else
	echo
	echo 'That is not an appropriate answer.  Goodbye'
fi

