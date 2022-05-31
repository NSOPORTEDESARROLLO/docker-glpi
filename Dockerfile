FROM debian:bullseye

RUN	apt-get update; apt-get -y upgrade; \
	apt-get -y install php php-curl php-zip \
	php-gd php-intl php-pear php-imagick \
	php-imap php-memcache php-pspell \
	php-tidy php-xmlrpc \
	php-xsl php-mbstring  \
	php-ldap php-cas php-apcu php-bz2 \ 
	libapache2-mod-php php-mysql cron \
	apache2


ADD	files/glpi-10.0.0.tgz /tmp
COPY files/apache2.conf /etc/apache2/

RUN	rm -rf /var/www/html; \
	mv /tmp/glpi /var/www/html; \
	chown -R www-data.www-data /var/www/html; \
	echo "SHELL=/bin/bash" > /etc/cron.d/glpi; \
	echo "" >> /etc/cron.d/glpi; \
 	echo "*/1 * * * * root /usr/bin/php /var/www/html/front/cron.php" >> /etc/cron.d/glpi; \
 	chmod 0644 /etc/cron.d/glpi; \
 	crontab /etc/cron.d/glpi

VOLUME /var/www/html/config /var/www/html/files
EXPOSE 80


CMD bash -c "/etc/init.d/cron start; apache2ctl -D FOREGROUND"


