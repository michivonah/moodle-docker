FROM debian:latest

# Install  updates
RUN apt-get update && apt-get upgrade -y
RUN apt-get install curl unzip wget -y

# Install webserver
RUN apt-get install apache2 -y

# Install PHP with extensions
RUN apt-get install php libapache2-mod-php php-iconv php-intl php-soap php-zip php-curl php-mbstring php-mysql php-gd php-xml php-pspell php-json php-xmlrpc -y

# Install MariaDB
RUN apt-get install mariadb-server mariadb-client -y
#RUN systemctl enable mariadb
#RUN systemctl restart mariadb

# Run script
RUN mkdir app
WORKDIR /app/
COPY app.sh .
RUN bash app.sh

# Expose ports
EXPOSE 80/tcp

# Test
CMD ["sh"]