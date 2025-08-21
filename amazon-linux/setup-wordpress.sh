#!/bin/bash
# WordPress LAMP Auto-Setup on Amazon Linux 2
# Run this as root or with sudo

DB_NAME="wordpress"
DB_USER="wp_user"
DB_PASS="StrongPassword@123"

# Update system
yum update -y

# Install Apache
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Install PHP
amazon-linux-extras enable php8.0
yum install -y php php-cli php-mysqlnd php-fpm

# Restart Apache to load PHP
systemctl restart httpd

# Install MariaDB (MySQL)
yum install -y mariadb105-server
systemctl start mariadb
systemctl enable mariadb

# Secure MariaDB (non-interactive version)
mysql -e "DELETE FROM mysql.user WHERE User='';"
mysql -e "DROP DATABASE IF EXISTS test;"
mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
mysql -e "FLUSH PRIVILEGES;"

# Create WordPress database and user
mysql -e "CREATE DATABASE ${DB_NAME};"
mysql -e "CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';"
mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

# Download WordPress
cd /tmp
wget https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
mv wordpress /var/www/html/

# Set permissions
chown -R apache:apache /var/www/html/wordpress
chmod -R 755 /var/www/html/wordpress

# Configure Apache Virtual Host
cat <<EOL > /etc/httpd/conf.d/wordpress.conf
<VirtualHost *:80>
    DocumentRoot /var/www/html/wordpress
    <Directory /var/www/html/wordpress>
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOL

# Enable .htaccess
sed -i 's/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf

# Restart Apache
systemctl restart httpd

echo "✅ WordPress setup completed!"
echo "👉 Open http://<your-ec2-public-ip>/ to finish installation via browser."
