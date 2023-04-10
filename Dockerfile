FROM debian:latest

# Install  updates
RUN apt-get update && apt-get upgrade -y

# Install webserver
RUN apt-get install apache2 -y

# Install PHP with extensions
RUN apt-get install php libapache2-mod-php php-iconv php-intl php-soap php-zip php-curl php-mbstring php-mysql php-gd php-xml php-pspell php-json php-xmlrpc -y

# Install MariaDB
RUN apt-get install mariadb-server mariadb-client -y
RUN systemctl enable mariadb
RUN systemctl restart mariadb

# Create db
RUN mysql -e "CREATE DATABASE moodledb;"
RUN mysql -e "CREATE USER moodle@localhost IDENTIFIED BY 'moodle';"
RUN mysql -e "GRANT ALL PRIVILEGES ON moodledb.* TO moodle@localhost"
RUN mysql -e "FLUSH PRIVILEGES"

# Download moodle
RUN curl -o moodle.zip https://download.moodle.org/download.php/stable401/moodle-latest-401.zip
RUN unzip moodle.zip -d /var/www/html/
RUN cd /var/www/
RUN mkdir moodledata
RUN chown -R www-data:www-data moodle
RUN chown -R www-data:www-data moodledata
RUN chmod -R 755 moodle
RUN chmod -R 755 moodledata

# Install moodle

# Test
CMD ["ls"]