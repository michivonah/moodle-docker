#!/bin/bash  

# Script for installing moodle on a new debian server
# For educational purpose only
# Michi von Ah - April 2023

# Get database info
read -p "Database Name: " dbName
read -p "Database Username: " dbUser
read -p "Database Password: " dbPassword
dbPasswordSyntax="'${dbPassword}'"

# Install updates
apt-get update && apt-get upgrade -y

# Install tools
apt-get install curl unzip wget -y

# Install php with needed extensions
apt-get install php libapache2-mod-php php-iconv php-intl php-soap php-zip php-curl php-mbstring php-mysql php-gd php-xml php-pspell php-json php-xmlrpc -y

# Install mariadb
apt-get install mariadb-server mariadb-client -y

# Create database
sudo mysql -e "CREATE DATABASE ${dbname};"
sudo mysql -e "CREATE USER ${dbUser}@localhost IDENTIFIED BY ${dbPasswordSyntax}";
sudo mysql -e "GRANT ALL PRIVILEGES ON ${dbname}.* TO ${dbUser}@localhost"
sudo mysql -e "FLUSH PRIVILEGES"

# Create app directory
cd /
mkdir app
cd app

# Download moodle
wget https://github.com/michivonah/moodle-docker/raw/main/moodle-download/moodle.zip
unzip moodle.zip -d /var/www/html/
cd /var/www/
mkdir moodle
mkdir moodledata
chown -R www-data:www-data html
chown -R www-data:www-data moodle
chown -R www-data:www-data moodledata
chmod -R 755 html
chmod -R 755 moodle
chmod -R 755 moodledata

# change PHP configuration
cd /etc/php/7.4/apache2/
echo '; ;;;;;;;;;;;;;;' >> php.ini
echo '; CUSTOM CHANGES FOR MOODLE ;' >> php.ini
echo 'extension=mysql.so' >> php.ini
echo 'extension=gd.so' >> php.ini
echo '; ;;;;;;;;;;;;;;' >> php.ini
sed -i "s#memory_limit = 128M#memory_limit = 196M#g" php.ini
sed -i "s#post_max_size = 8M#post_max_size = 80M#g" php.ini
sed -i "s#upload_max_filesize = 2M#upload_max_filesize = 80M#g" php.ini
sed -i "s#;max_input_vars = 1000#max_input_vars = 5000#g" php.ini

# change apache2 configuration
cd /etc/apache2/sites-available/
sed -i "s#var/www/html#var/www/html/moodle#g" 000-default.conf
/etc/init.d/apache2 restart

# change moodle configuration
cd /var/www/html/moodle/
sed -i "s/mysqli/mariadb/g" config.php

# End
echo 'Moodle installed successfully'