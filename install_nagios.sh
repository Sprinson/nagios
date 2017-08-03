#!/bin/sh


echo '#######################################'
echo '# ADDING REQUIRED NAGIOS TOOLS'
echo '#######################################'
echo 'NAGIOS TOOLS' >> $INSTALL_LOG
sleep 2
yum install gcc glibc glibc-common gd gd-devel make net-snmp openssl-devel xinetd unzip -y
echo  'yum install gcc glibc glibc-common gd gd-devel make net-snmp openssl-devel xinetd unzip -y' >> $INSTALL_LOG

cd /usr/local/src
echo 'cd /usr/local/src' >> $INSTALL_LOG

curl -L -O https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.1.1.tar.gz 
echo 'curl -L -O https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.1.1.tar.gz' >> $INSTALL_LOG

tar xvzf nagios-4.1.1.tar.gz
echo 'tar xvzf nagios-4.1.1.tar.gz' >> $INSTALL_LOG

cd nagios-4.1.1
echo 'cd nagios-4.1.1' >> $INSTALL_LOG

./configure --with-command-group=nagcmd
echo './configure --with-command-group=nagcmd' >> $INSTALL_LOG

make all; make install; make install-commandmode; make install-init; make install-web-conf
echo 'make all; make install; make install-commandmode; make install-init; make install-web-conf' >> $INSTALL_LOG

usermod -G nagcmd apache
echo 'usermod -G nagcmd apache'

cd /usr/local/src
echo 'cd /usr/local/src' >> $INSTALL_LOG

curl -L -O http://nagios-plugins.org/download/nagios-plugins-2.1.1.tar.gz
echo 'curl -L -O http://nagios-plugins.org/download/nagios-plugins-2.1.1.tar.gz' >> $INSTALL_LOG

tar xvzf nagios-plugins-2.1.1.tar.gz; cd nagios-plugins-2.1.1
echo 'tar xvzf nagios-plugins-2.1.1.tar.gz; cd nagios-plugins-2.1.1' >> $INSTALL_LOG

./configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl; make; make install
echo './configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl; make; make install'  >> $INSTALL_LOG

cd /usr/local/src
echo 'cd /usr/local/src' >> $INSTALL_LOG

curl -L -O http://downloads.sourceforge.net/project/nagios/nrpe-2.x/nrpe-2.15/nrpe-2.15.tar.gz
echo 'curl -L -O http://downloads.sourceforge.net/project/nagios/nrpe-2.x/nrpe-2.15/nrpe-2.15.tar.gz' >> $INSTALL_LOG

tar xvzf http://downloads.sourceforge.net/project/nagios/nrpe-2.x/nrpe-2.15/nrpe-2.15.tar.gz
echo 'tar xvzf http://downloads.sourceforge.net/project/nagios/nrpe-2.x/nrpe-2.15/nrpe-2.15.tar.gz' >> $INSTALL_LOG

tar xvzf nrpe-2.15.tar.gz
echo 'tar xvzf nrpe-2.15.tar.gz' >> $INSTALL_LOG

cd nrpe-2.15
echo 'cd nrpe-2.15' >> $INSTALL_LOG

./configure --enable-command-args --with-nagios-user=nagios --with-nagios-group=nagios --with-ssl=/usr/bin/openssl --with-ssl-lib=/usr/lib/x86_64-linux-gnu
echo './configure --enable-command-args --with-nagios-user=nagios --with-nagios-group=nagios --with-ssl=/usr/bin/openssl --with-ssl-lib=/usr/lib/x86_64-linux-gnu' >> $INSTALL_LOG

make all; make install; make install-xinetd; make install-daemon-config
echo 'make all; make install; make install-xinetd; make install-daemon-config' >> $INSTALL_LOG

rm -f /etc/xinetd.d/nrpe; cp $INSTALL_CFGS/nrpe /etc/xinetd.d/; service xinetd restart
echo 'rm -f /etc/xinetd.d/nrpe; cp $INSTALL_CFGS/nrpe /etc/xinetd.d/; service xinetd restart' >> $INSTALL_LOG
