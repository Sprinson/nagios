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
yum install libssh2 -y
echo 'yum install libssh2 -y' >> $INSTALL_LOG
yum install libssh2-devel -y
echo 'yum install libssh2-devel -y' >> $INSTALL_LOG
yum install php-pear -y
echo 'yum install php-pear -y' >> $INSTALL_LOG
pecl channel-update pecl.php.net
echo 'pecl channel-update pecl.php.net' >> $INSTALL_LOG
yum install libssh2-1-dev -y
echo 'yum install libssh2-1-dev -y' >> $INSTALL_LOG
yum install php-devel -y
echo 'yum install php-devel -y' >> $INSTALL_LOG
pecl install -a ssh2
echo 'pecl install -a ssh2' >> $INSTALL_LOG
systemctl restart httpd.service
echo 'systemctl restart httpd.service' >> $INSTALL_LOG