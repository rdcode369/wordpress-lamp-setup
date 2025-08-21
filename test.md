
# 🚀 WordPress Deployment on AWS EC2 (Amazon Linux 2 & Ubuntu)

This guide walks you through deploying **WordPress on AWS EC2** using a **LAMP stack (Linux, Apache, MySQL, PHP)**.  
It covers both **Amazon Linux 2** and **Ubuntu (20.04/22.04)** with step-by-step instructions.

---

## 📖 Manual Setup vs Automated Setup

| Approach       | Pros ✅ | Cons ❌ |
|----------------|--------|---------|
| **Manual Setup** | - Learn how each component works<br>- Full control over configuration | - Time-consuming<br>- Error-prone if steps missed |
| **Automated Setup (script)** | - Quick & repeatable<br>- Best for production & scaling | - Less educational<br>- Must maintain script |

---

## 🖥️ Step 1: Launch EC2 Instance

1. Log in to [AWS Management Console](https://aws.amazon.com/console/).  
2. Go to **EC2** → Launch an Instance.  
3. Choose:
   - **Amazon Linux 2 AMI** OR **Ubuntu 20.04/22.04 LTS**  
   - Instance type: `t2.micro` (Free Tier eligible).  
4. Configure **Security Group**:
   - Allow **HTTP (80)**, **HTTPS (443)**, **SSH (22)**.  
5. Launch and connect using SSH:
   ```bash
   ssh -i your-key.pem ec2-user@<EC2-Public-IP>   # Amazon Linux
   ssh -i your-key.pem ubuntu@<EC2-Public-IP>     # Ubuntu
   ```

---

## ⚡ Step 2: Update Packages

**Amazon Linux 2:**
```bash
sudo yum update -y
```

**Ubuntu:**
```bash
sudo apt update && sudo apt upgrade -y
```

---

## 🌐 Step 3: Install Apache

**Amazon Linux 2:**
```bash
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
```

**Ubuntu:**
```bash
sudo apt install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
```

Test in browser → `http://<EC2-Public-IP>`  

---

## 🛢️ Step 4: Install MySQL Server

**Amazon Linux 2:**
```bash
sudo yum install -y mariadb105-server
sudo systemctl start mariadb
sudo systemctl enable mariadb
```

**Ubuntu:**
```bash
sudo apt install -y mysql-server
sudo systemctl start mysql
sudo systemctl enable mysql
```

Secure MySQL:
```bash
sudo mysql_secure_installation
```

---

## 💻 Step 5: Install PHP

**Amazon Linux 2:**
```bash
sudo amazon-linux-extras enable php8.0
sudo yum install -y php php-mysqlnd php-fpm php-json
sudo systemctl restart httpd
```

**Ubuntu:**
```bash
sudo apt install -y php libapache2-mod-php php-mysql
sudo systemctl restart apache2
```

---

## 🛠️ Step 6: Configure MySQL Database for WordPress

Login to MySQL:
```bash
sudo mysql -u root -p
```

Inside MySQL shell:
```sql
CREATE DATABASE wordpress;
CREATE USER 'wp_user'@'localhost' IDENTIFIED BY 'StrongPassword@123';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

---

## 📦 Step 7: Download & Configure WordPress

```bash
cd /tmp
wget https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz
sudo mv wordpress /var/www/html/
```

Set permissions:
```bash
sudo chown -R apache:apache /var/www/html/wordpress   # Amazon Linux
sudo chown -R www-data:www-data /var/www/html/wordpress   # Ubuntu
sudo chmod -R 755 /var/www/html/wordpress
```

---

## ⚙️ Step 8: Configure Apache

Edit the default config file:  

**Amazon Linux 2:**
```bash
sudo nano /etc/httpd/conf/httpd.conf
```

**Ubuntu:**
```bash
sudo nano /etc/apache2/sites-available/000-default.conf
```

Change DocumentRoot:
```
DocumentRoot /var/www/html/wordpress
```

Restart Apache:

**Amazon Linux 2:**
```bash
sudo systemctl restart httpd
```

**Ubuntu:**
```bash
sudo systemctl restart apache2
```

---

## 🌍 Step 9: Finish WordPress Setup

Open in browser:
```
http://<EC2-Public-IP>
```

Follow on-screen setup:  
- Choose Language  
- Enter DB details (`wordpress`, `wp_user`, `StrongPassword@123`)  
- Create WordPress Admin User  

Done 🎉 WordPress is ready!

---

## 📌 (Optional) Assign a Static IP (Elastic IP)
If you want your server’s IP to stay the same after reboots:
1. EC2 → **Elastic IPs** → **Allocate Elastic IP address**.
2. **Associate** it with your instance.
3. Update any DNS records (if you’re using a domain).

> **Note:** Elastic IPs may incur charges when not in use—release them if you terminate the instance.

## 📌 Basic Admin & Troubleshooting

**Service names differ by OS:**  
- Apache → `httpd` (Amazon Linux) vs `apache2` (Ubuntu)  
- Database → `mariadb` (Amazon Linux) vs `mysql` (Ubuntu)

**Check status / restart:**
```bash
# Amazon Linux
sudo systemctl status httpd
sudo systemctl status mariadb
sudo systemctl restart httpd
sudo systemctl restart mariadb

# Ubuntu
sudo systemctl status apache2
sudo systemctl status mysql
sudo systemctl restart apache2
sudo systemctl restart mysql
```

**Firewall tips:**
- On Ubuntu, if UFW is enabled: `sudo ufw allow 'Apache Full'`
- Ensure Security Group has inbound `80/443` open

**Common issues:**
- **403/404 or pretty links broken** → enable Apache rewrite module (Ubuntu): `sudo a2enmod rewrite && sudo systemctl reload apache2`
- **Permission errors on uploads** → ensure WordPress dir ownership:
  - Amazon Linux: `sudo chown -R apache:apache /var/www/html/wordpress`
  - Ubuntu: `sudo chown -R www-data:www-data /var/www/html/wordpress`

---

## 📌 Keep It Updated
```bash
# Amazon Linux
sudo yum update -y

# Ubuntu
sudo apt update -y && sudo apt upgrade -y
```

---

## 📌 Clean Up (to avoid charges)
- **Terminate** the instance if you’re done (EC2 → Instances → Instance state → Terminate).
- **Release** any **Elastic IP** (EC2 → Elastic IPs).
- Remove DNS records if you pointed a domain.

---

## 📌 Best Practices

- Always **change default DB password**.  
- Use **security groups** & firewall rules.  
- Set up **HTTPS** (Let’s Encrypt).  
- Regularly update system & WordPress plugins.  

---

### ✅ You’re all set!
You now have a reproducible way to launch an EC2 instance and deploy WordPress with a single script or via User Data.

---

## 📌 Next Steps

- Automate with shell scripts (provided in repo).  
- Set up a custom domain with Route 53.  
- Configure SSL certificates for production.  

---
