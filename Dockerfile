FROM debian:latest

# Install  updates
RUN apt-get update && apt-get upgrade -y

# Install webserver
RUN apt-get install apache2 -y
RUN systemctl start apache2
RUN systemctl enable apache2

# Install PHP with extensions
RUN apt-get install php libapache2-mod-php php-iconv php-intl php-soap php-zip php-curl php-mbstring php-mysql php-gd php-xml php-pspell php-json php-xmlrpc -y

# Install MariaDB
RUN apt-get install mariadb-server mariadb-client -y
RUN systemctl start mariadb
RUN systemctl enable mariadb

# Create db
RUN mysql -e "CREATE DATABASE moodledb;"
RUN mysql -e "CREATE USER moodle@localhost IDENTIFIED BY 'moodle';"
RUN mysql -e "GRANT ALL PRIVILEGES ON moodledb.* TO moodle@localhost"
RUN mysql -e "FLUSH PRIVILEGES"

# Download moodle
RUN curl -o moodle.zip https://download.moodle.org/download.php/stable401/moodle-latest-401.zip
RUN unzip moodle.zip -d /var/www/html/

# Install moodle

# Test
CMD ["ls"]