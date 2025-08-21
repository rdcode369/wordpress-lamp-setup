#!/bin/bash
# WordPress LAMP Setup Script for Ubuntu 20.04/22.04
# Author: Your Name
# GitHub: <your-repo-url>

# =============================
# Variables (Edit as needed)
# =============================
DB_NAME="wordpress"
DB_USER="wp_user"
DB_PASS="StrongPassword@123"

# =============================
# Update & Install Packages
# =============================
apt update -y
apt upgrade -y

# Install Apache
apt install -y apache2

# Install MySQL
apt install -y mysql-server

# Install PHP & Extensions
apt install -y php libapache2-mod-php php-mysql php-cli php-curl php-gd php-xml php-mbstring unzip wget

# Enable services
systemctl enable apache2
systemctl enable mysql
systemctl start apache2
systemctl start mysql

# =============================
# MySQL Configuration
# =============================
mysql -e "DELETE FROM mysql.user WHERE User='';"
mysql -e "DROP DATABASE IF EXISTS test;"
mysql -e "FLUSH PRIVILEGES;"
mysql -e "CREATE DATABASE ${DB_NAME};"
mysql -e "CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';"
mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

# =============================
# Download & Configure WordPress
# =============================
cd /tmp
wget https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
rm -rf /var/www/html/wordpress
mv wordpress /var/www/html/

# Set permissions
chown -R www-data:www-data /var/www/html/wordpress
chmod -R 755 /var/www/html/wordpress

# =============================
# Apache Virtual Host
# =============================
cat <<EOL > /etc/apache2/sites-available/wordpress.conf
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html/wordpress
    <Directory /var/www/html/wordpress>
        AllowOverride All
        Require all granted
    </Directory>
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOL

# Disable default site & enable WordPress site
a2dissite 000-default.conf
a2ensite wordpress.conf

# Enable Apache rewrite module for permalinks
a2enmod rewrite

# Restart Apache
systemctl reload apache2

echo "======================================"
echo " WordPress installation is complete!"
echo " Open your browser and visit:"
echo "   http://<your-server-ip>/"
echo "======================================"
