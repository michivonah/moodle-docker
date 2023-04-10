#!/bin/bash  

# Install moodle
# Michi von Ah - April 2023

# Create db
sudo mysql -e "CREATE DATABASE moodledb;"
sudo mysql -e "CREATE USER moodle@localhost IDENTIFIED BY 'moodle';"
sudo mysql -e "GRANT ALL PRIVILEGES ON moodledb.* TO moodle@localhost"
sudo mysql -e "FLUSH PRIVILEGES"

# Download moodle
curl -o moodle.zip https://download.moodle.org/download.php/stable401/moodle-latest-401.zip
mkdir /var/www/moodle/
unzip moodle.zip -d /var/www/html/
cd /var/www/
mkdir moodledata
chown -R www-data:www-data moodle
chown -R www-data:www-data moodledata
chmod -R 755 moodle
chmod -R 755 moodledata

# change apache2 configuration
#sed 's+/var/www/html+/var/www/moodle+g' 000-default.conf
#sed -i 's#root /var/www/html#root /var/www/moodle#' 000-default.conf
#/etc/init.d/apache2 restart
