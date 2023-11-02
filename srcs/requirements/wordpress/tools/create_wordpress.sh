#!/bin/sh

if [ -f ./wp-config.php ]
then
	echo "wordpress already downloaded"
else

	wget https://wordpress.org/wordpress-6.0.tar.gz
	tar xfz wordpress-6.0.tar.gz
	mv wordpress/* .
	rm -rf wordpress-6.0.tar.gz
	rm -rf wordpress

	sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
	cp wp-config-sample.php wp-config.php

	sleep 10

	wp core install --url=$DOMAIN_NAME --title=$SITE_TITLE --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --allow-root --path='/var/www/html'

	wp user create --allow-root --role=author $USER1_LOGIN $USER1_EMAIL --user_pass=$USER1_PASSWORD --path='/var/www/html' >> log.txt

fi

exec "$@"
