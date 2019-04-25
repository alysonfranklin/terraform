#!/bin/bash
# Instalação do zabbix-server

sudo apt-get update
sudo apt-get install -y apache2 libapache2-mod-php htop
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password 123qwe'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password 123qwe'
sudo apt-get -y install mysql-server
sudo apt-get install -y php php-mbstring php-gd php-xml php-bcmath php-ldap php-mysql 
sudo sed -i 's/;date\.timezone =/date\.timezone = Asia\/Tokyo/' /etc/php5/apache2/php.ini

wget http://repo.zabbix.com/zabbix/3.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_3.4-1+xenial_all.deb
sudo dpkg -i zabbix-release_3.4-1+xenial_all.deb

sudo apt-get update
sudo apt-get install -y zabbix-server-mysql zabbix-frontend-php

sudo cat <<EOF >> /etc/sysctl.conf
net.ipv4.neigh.default.gc_thresh1 = 512
net.ipv4.neigh.default.gc_thresh2 = 2048
net.ipv4.neigh.default.gc_thresh3 = 4096
fs.file-max = 65536
kernel.shmmax = 2147483648
kernel.shmall = 524288
EOF
sysctl -p

sudo ulimit -n 65536
cat <<EOF >> /etc/security/limits.conf
* soft nofile 65536
* hard nofile 65536
EOF

sudo mysql -uroot -p123qwe -e "create database zabbix character set utf8;"
sudo mysql -uroot -p123qwe -e "grant all privileges on zabbix.* to zabbix@'${ZABBIX_SERVER_IP}' identified by 'zabbix';"
sudo mysql -uroot -p123qwe -e "FLUSH PRIVILEGES;"

sudo cd /usr/share/doc/zabbix-server-mysql
sudo zcat create.sql.gz | sudo mysql -uroot -p123qwe -p zabbixdb

sudo service apache2 restart
sudo service zabbix-server restart
