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
read -n 1 -s -r -p "Press any key to continue"
$INSTALL_SCRIPTS/install_users.sh
echo
echo '#######################################'
echo '# TIME TO INSTALL THE TOOLS'
echo '#######################################'
echo
read -n 1 -s -r -p "Press any key to continue"
$INSTALL_SCRIPTS/install_tools.sh
echo
echo '#######################################'
echo '# TIME TO INSTALL NAGIOS'
echo '#######################################'
echo
read -n 1 -s -r -p "Press any key to continue"
$INSTALL_SCRIPTS/install_nagios.sh 
