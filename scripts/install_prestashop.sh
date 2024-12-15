#!/bin/bash

# Variables
DB_NAME=prestashop_db
DB_USER=prestashop_user
DB_PASSWORD=securepassword
PRESTASHOP_URL="https://download.prestashop.com/download/releases/prestashop_1.7.8.8.zip"
PRESTASHOP_DIR="/var/www/html/prestashop"

# Actualizar sistema
sudo apt update && sudo apt upgrade -y

# Instalar requisitos previos
sudo apt install apache2 mysql-server php php-mysql php-curl php-zip php-intl unzip -y

# Configurar MySQL
sudo mysql -u root -e "CREATE DATABASE $DB_NAME DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
sudo mysql -u root -e "CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';"
sudo mysql -u root -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';"
sudo mysql -u root -e "FLUSH PRIVILEGES;"

# Descargar y descomprimir Prestashop
wget $PRESTASHOP_URL -O prestashop.zip
sudo unzip prestashop.zip -d /var/www/html/
sudo chown -R www-data:www-data $PRESTASHOP_DIR
sudo chmod -R 755 $PRESTASHOP_DIR

# Configurar Apache
sudo bash -c "cat > /etc/apache2/sites-available/prestashop.conf << EOF
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot $PRESTASHOP_DIR
    <Directory $PRESTASHOP_DIR>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF"

sudo a2ensite prestashop.conf
sudo a2enmod rewrite
sudo systemctl restart apache2

# Configuración final
echo "Prestashop instalado en $PRESTASHOP_DIR. Configuración lista."
