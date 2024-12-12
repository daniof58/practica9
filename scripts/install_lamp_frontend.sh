#!/bin/bash

# Muestra todos los comandos que se van ejecutando:
set -ex

# Actualizamos los repositorios:
apt update

#Actualizar los paquetes:
#apt upgrade -y

#Instalación de Apache:
apt install apache2 -y

#Habilitamos el módulo rewrite:
a2enmod rewrite

#Instalación PHP y algunos modulos de PHP para Apache y MySQL:
sudo apt install php libapache2-mod-php php-mysql -y

#Copiamos el archivo de configuración de Apache:
cp ../conf/000-default.conf /etc/apache2/sites-available

#Reiniciamos el servidor Apache:
systemctl restart apache2

#Copiamos nuestro archivo de prueba de PHP en /var/www/html:
cp ../php/index.php /var/www/html

#Modificamos el propietario y el grupo de index.php:
chown -R www-data:www-data /var/www/html