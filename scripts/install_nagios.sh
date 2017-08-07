#!/bin/sh
echo '#######################################'
echo '# ADDING REQUIRED NAGIOS TOOLS'
echo '#######################################'
echo 'NAGIOS TOOLS' >> $INSTALL_LOG
sleep 2
echo
yum install gcc glibc glibc-common gd gd-devel make net-snmp openssl-devel xinetd unzip -y
echo 'yum install gcc glibc glibc-common gd gd-devel make net-snmp openssl-devel xinetd unzip -y' >> $INSTALL_LOG

cd ~
echo 'cd ~' >> $INSTALL_LOG

curl -L -O https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.1.1.tar.gz
echo 'curl -L -O https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.1.1.tar.gz' >> $INSTALL_LOG

tar xvf nagios-*.tar.gz
echo 'tar xvf nagios-*.tar.gz' >> $INSTALL_LOG

cd nagios-*
echo 'cd nagios-*' >> $INSTALL_LOG

./configure --with-command-group=nagcmd
echo './configure --with-command-group=nagcmd' >> $INSTALL_LOG

make all
echo 'make all' >> $INSTALL_LOG

make install
echo 'make install' >> $INSTALL_LOG

make install-commandmode
echo 'make install-commandmode' >> $INSTALL_LOG

make install-init
echo 'make install-init' >> $INSTALL_LOG

make install-config
echo 'make install-config' >> $INSTALL_LOG

make install-webconf
echo 'make install-webconf' >> $INSTALL_LOG

usermod -G nagcmd apache
echo 'usermod -G nagcmd apache' >> $INSTALL_LOG

cd ~
echo 'cd ~' >> $INSTALL_LOG

curl -L -O http://nagios-plugins.org/download/nagios-plugins-2.1.1.tar.gz
echo 'curl -L -O http://nagios-plugins.org/download/nagios-plugins-2.1.1.tar.gz' >> $INSTALL_LOG

tar xvf nagios-plugins-*.tar.gz
echo 'tar xvf nagios-plugins-*.tar.gz' >> $INSTALL_LOG

cd nagios-plugins-*
echo 'cd nagios-plugins-*' >> $INSTALL_LOG

./configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl
echo './configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl' >> $INSTALL_LOG

make
echo 'make' >> $INSTALL_LOG

make install
echo 'make install' >> $INSTALL_LOG

cd ~
echo 'cd ~' >> $INSTALL_LOG

curl -L -O http://downloads.sourceforge.net/project/nagios/nrpe-2.x/nrpe-2.15/nrpe-2.15.tar.gz
echo 'curl -L -O http://downloads.sourceforge.net/project/nagios/nrpe-2.x/nrpe-2.15/nrpe-2.15.tar.gz' >> $INSTALL_LOG

tar xvf nrpe-*.tar.gz
echo 'tar xvf nrpe-*.tar.gz' >> $INSTALL_LOG

cd nrpe-*
echo 'cd nrpe-*' >> $INSTALL_LOG

./configure --enable-command-args --with-nagios-user=nagios --with-nagios-group=nagios --with-ssl=/usr/bin/openssl --with-ssl-lib=/usr/lib/x86_64-linux-gnu
echo './configure --enable-command-args --with-nagios-user=nagios --with-nagios-group=nagios --with-ssl=/usr/bin/openssl --with-ssl-lib=/usr/lib/x86_64-linux-gnu' >> $INSTALL_LOG

make all
echo 'make all' >> $INSTALL_LOG

make install 
echo 'make install' >> $INSTALL_LOG

make install-xinetd
echo 'make install-xinetd' >> $INSTALL_LOG

make install-daemon-config
echo 'make install-daemon-config' >> $INSTALL_LOG


##Assigns the server's IP address to a variable to be used in configuring /etc/xinetd.d/nrpe
#MY_IP=$(ip route get 8.8.8.8 | awk '/8.8.8.8/ {print $NF}')
#echo 'MY_IP=$(ip route get 8.8.8.8 | awk '/8.8.8.8/ {print $NF}')' >> $INSTALL_LOG
#sed -i "/^only_from/s/$/$MY_IP/" "/etc/xinetd.d/nrpe"
#echo 'sed -i "/^only_from/s/$/$MY_IP/" "/etc/xinetd.d/nrpe"' >> $INSTALL_LOG

service xinetd restart
echo 'service xinetd restart' >> $INSTALL_LOG

htpasswd -b -c /usr/local/nagios/etc/htpasswd.users nagiosadmin nagios
echo 'htpasswd -b -c /usr/local/nagios/etc/htpasswd.users nagiosadmin nagios' >> $INSTALL_LOG

service nagios start
echo 'service nagios start' >> $INSTALL_LOG

systemctl restart httpd.service
echo 'systemctl restart httpd.service' >> $INSTALL_LOG

chkconfig nagios on
echo 'chkconfig nagios on' >> $INSTALL_LOG

