FROM debian:latest

# Install  updates
RUN apt-get update && apt-get upgrade -y

# Install webserver
RUN apt-get install apache2 -y
RUN systemctl start apache2
RUN systemctl enable apache2

# Install PHP with extensions
RUN apt-get install php libapache2-mod-php php-iconv php-intl php-soap php-zip php-curl php-mbstring php-mysql php-gd php-xml php-pspell php-json php-xmlrpc -y

# Test
CMD ["ls"]