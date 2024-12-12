#!/bin/bash

# Muestra todos los comandos que se van ejecutando:
set -ex

# Actualizamos los repositorios:
apt update

#Actualizar los paquetes:
#apt upgrade -y

# Importamos el archivo de variables .env:
source .env

#Instalación MySQL:
apt install mysql-server -y

#Configuramos el archivo /etc/mysql/mysql.conf.d/mysqld.cnf:
sed -i "s/127.0.0.1/$BACKEND_PRIVATE_IP/" /etc/mysql/mysql.conf.d/mysqld.cnf

#Reiniciamos el servicio MySQL:
systemctl restart mysql