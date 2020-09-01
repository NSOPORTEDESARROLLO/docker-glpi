FROM debian:buster

RUN	apt-get update; apt-get -y upgrade; \
	apt-get -y install php7.3 php7.3-curl php7.3-zip \
	php7.3-gd php7.3-intl php-pear php-imagick \
	php7.3-imap php-memcache php7.3-pspell \
	php7.3-recode php7.3-tidy php7.3-xmlrpc \
	php7.3-xsl php7.3-mbstring php-gettext \
	php7.3-ldap php-cas php-apcu php7.3-bz2 \ 
	libapache2-mod-php7.3 php7.3-mysql cron \
	apache2


ADD	files/glpi-9.5.1.tgz /tmp
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


