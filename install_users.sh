#!/bin/sh

echo '########################################'
echo '#ADDING NAGIOS USER / GROUP'
echo '########################################'
echo 'USERS' >> $INSTALL_LOG
sleep 2
useradd nagios
echo 'useradd nagios' >> $INSTALL_LOG
groupadd nagcmd
echo 'groupadd nagcmd' >> $INSTALL_LOG
usermod -a -G nagcmd nagios
echo 'usermod -a -G nagcmd nagios' >> $INSTALL_LOG