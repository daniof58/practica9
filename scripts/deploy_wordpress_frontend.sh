#!/bin/bash

# Muestra todos los comandos que se van ejecutando:
set -ex

# Importamos el archivo de variables .env:
source .env

#Eliminamos instalaciones previas:
rm -rf /tmp/wp-cli.phar

#Descargamos WP-CLI:
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -P /tmp

#Le damos permisos de ejecución:
chmod +x /tmp/wp-cli.phar

#Movemos el script directorio /usr/local/bin:
mv /tmp/wp-cli.phar /usr/local/bin/wp

#Eliminamos instalaciones previas:
rm -rf /var/www/html/*

#Descargamos el codigo fuente de WordPress:
wp core download --locale=es_ES --path=$RUTA --allow-root

#Cambiamos el propietario /var/www/html:
chown -R www-data:www-data /var/www/html/

#Creamos el archivo de configuración:
wp config create \
  --dbname=$WORDPRESS_DB_NAME \
  --dbuser=$WORDPRESS_DB_USER \
  --dbpass=$WORDPRESS_DB_PASSWORD \
  --dbhost=$WORDPRESS_DB_HOST \
  --path=$RUTA \
  --allow-root

#Instalamos WordPress:
wp core install \
  --url=$CB_DOMAIN\
  --title="$WORDPRESS_TITLE" \
  --admin_user=$WORDPRESS_ADMIN_USER \
  --admin_password=$WORDPRESS_ADMIN_PASS \
  --admin_email=$CB_EMAIL \
  --path=$RUTA \
  --allow-root

#Instalamos y activamos el tema:
wp theme install astra --activate --path=$RUTA --allow-root

#Instalamos un plugin de url:
wp plugin install wps-hide-login --activate --path=$RUTA --allow-root

#Configuramos el plugin de url:
wp option update whl_page "$WORDPRESS_HIDE_LOGIN_URL" --path=$RUTA --allow-root

#Enlaces permanentes:
wp rewrite structure '/%postname%/' --path=$RUTA --allow-root

#Copiamos el archivo .htaccess:
cp ../htaccess/.htaccess /var/www/html

#Modificamos el propietario y el grupo del directorio de /var/www/html:
chown -R www-data:www-data /var/www/html