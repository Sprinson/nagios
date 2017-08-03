#!/bin/sh

echo '#######################################'
echo '# ADDING REQUIRED CORE DIAGNOSTIC TOOLS'
echo '#######################################'
echo 'DIAGNOSTIC TOOLS' >> $INSTALL_LOG
sleep 2
yum install telnet -y
echo 'yum install telnet -y'  >> $INSTALL_LOG
yum install wget -y
echo 'yum install wget -y'  >> $INSTALL_LOG
yum install tcpdump -y
echo 'yum install tcpdump'  >> $INSTALL_LOG
yum install sysstat -y
echo 'yum install sysstat -y'  >> $INSTALL_LOG
yum install strace -y
echo 'yum install strace -y'  >> $INSTALL_LOG

echo '#######################################'
echo '# ADDING MONITORING TOOLS'
echo '#######################################'
echo 'MONITORING TOOLS' >> $INSTALL_LOG
sleep 2
yum install httpd -y 
echo 'yum install httpd -y' >> $INSTALL_LOG
systemctl enable httpd
echo 'systemctl enable httpd' >> $INSTALL_LOG
systemctl start httpd.service
echo 'systemctl start httpd.service' >> $INSTALL_LOG
yum install mariadb-server mariadb -y
echo 'yum install mariadb-server mariadb -y' >> $INSTALL_LOG
systemctl enable mariadb
echo 'systemctl enable mariadb' >> $INSTALL_LOG
systemctl start mariadb
echo 'systemctl start mariadb' >> $INSTALL_LOG
mysql_secure_installation
echo 'mysql_secure_installation' >> $INSTALL_LOG
yum-install perl-Switch -y
echo 'yum-install perl-Switch -y' >> $INSTALL_LOG
yum install php php-mysql -y
echo 'yum install php php-mysql -y' >> $INSTALL_LOG
yum install libssh2
echo 'yum install libssh2' >> $INSTALL_LOG
yum install libssh2-devel
echo 'yum install libssh2-devel' >> $INSTALL_LOG
yum install php-pear
echo 'yum install php-pear' >> $INSTALL_LOG
pecl channel-update pecl.php.net
echo 'pecl channel-update pecl.php.net' >> $INSTALL_LOG
yum install libssh2-1-dev
echo 'yum install libssh2-1-dev' >> $INSTALL_LOG
yum install php-devel
echo 'yum install php-devel' >> $INSTALL_LOG
pecl install -a ssh2
echo 'pecl install -a ssh2' >> $INSTALL_LOG
systemctl restart httpd.service
echo 'systemctl restart httpd.service' >> $INSTALL_LOG

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
