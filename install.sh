#!/bin/bash
echo "Welcome to Budd Technology Services"
echo ""
echo "== InvoiceNinja AUTO INSTALL SCRIPT =="
echo "== DEDICATED SERVERS, VPS, SHARED HOSTING =="
echo "www.buddtechnology.com"
echo ""
echo "Please Wait! install will begin shortly..."
sleep 5
apt update
apt upgrade -y
apt install apache2 -y
apt install python3-certbot-apache -y
apt install unzip -y
apt-get install software-properties-common
wget -O invoice-ninja.zip https://download.invoiceninja.com/
mkdir -p /var/www/
unzip invoice-ninja.zip -d /var/www/
mv /var/www/ninja /var/www/invoice-ninja
chown www-data:www-data /var/www/invoice-ninja/ -R
chmod 755 /var/www/invoice-ninja/storage/ -R
apt install mariadb-server -y
add-apt-repository ppa:ondrej/php
apt install php-imagick php7.3-fpm php7.3-mysql php7.3-common php7.3-gd php7.3-json php7.3-curl php7.3-zip php7.3-xml php7.3-mbstring php7.3-bz2 php7.3-intl php7.3-gmp -y
a2dismod php7.4
a2dismod mpm_prefork
a2enmod mpm_event proxy_fcgi setenvif
systemctl restart apache2
mysql_secure_installation
