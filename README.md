After running the prereq install you need to create a database manually

To Create mysql database

create database invoiceninja;

create user ninja@localhost identified by 'SetPasswordHere';

grant all privileges on invoiceninja.* to ninja@localhost;

flush privileges;

exit;

Now we need to configure apache

Create a new file
sudo nano /etc/apache2/sites-available/invoice-ninja.conf

Paste the following and change the ServerName with your domain name.

<VirtualHost *:80>
    ServerName invoice.buddtechnology.com
    DocumentRoot /var/www/invoice-ninja/public

    <Directory /var/www/invoice-ninja/public>
       DirectoryIndex index.php
       Options +FollowSymLinks
       AllowOverride All
       Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/invoice-ninja.error.log
    CustomLog ${APACHE_LOG_DIR}/invoice-ninja.access.log combined

    Include /etc/apache2/conf-available/php7.3-fpm.conf
</VirtualHost>

Save the file

Run the following commands

sudo a2ensite invoice-ninja.conf
sudo a2enmod rewrite
sudo systemctl restart apache2

If you do see the default apache page run the following command to disable the default page.
disable sudo a2dissite 000-default.conf


Install SSL

sudo certbot --apache --agree-tos --redirect --hsts --staple-ocsp --email youremail@domain.com -d invoice.yourdomain.com

Setup Cron Jobs
sudo crontab -e

Paste

#InvoiceNinja
0 8 * * * /usr/bin/php7.3 /var/www/invoice-ninja/artisan ninja:send-invoices > /dev/null
0 8 * * * /usr/bin/php7.3 /var/www/invoice-ninja/artisan ninja:send-reminders > /dev/null
