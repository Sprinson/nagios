#!/bin/sh

export INSTALL_HOME=`pwd`
DATE=`date +%m-%d-%H-%M`
export INSTALL_LOG="$INSTALL_HOME/nagios_log/nagios_install_log_$DATE"
export INSTALL_CFGS="$INSTALL_HOME/cfgs"
echo
echo Logging Installation at $INSTALL_LOG