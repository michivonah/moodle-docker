#!/bin/bash  

# Install moodle
# Michi von Ah - April 2023

# Create db
sudo mysql -e "CREATE DATABASE moodledb;"
sudo mysql -e "CREATE USER moodle@localhost IDENTIFIED BY 'moodle';"
sudo mysql -e "GRANT ALL PRIVILEGES ON moodledb.* TO moodle@localhost"
sudo mysql -e "FLUSH PRIVILEGES"

# Download moodle
curl -o moodle.zip https://github.com/michivonah/moodle-docker/raw/main/moodle-download/moodle.zip
mkdir /var/www/moodle/
unzip moodle.zip -d /var/www/html/
cd /var/www/
mkdir moodledata
chown -R www-data:www-data moodle
chown -R www-data:www-data moodledata
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
