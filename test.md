# 📌 WordPress LAMP Setup (Amazon Linux & Ubuntu)

This repository provides automated scripts to install and configure a **LAMP stack** (Linux, Apache, MySQL/MariaDB, PHP) with **WordPress** on:

* ✅ Amazon Linux 2
* ✅ Ubuntu 20.04 / 22.04

Each environment has its own folder with:

* A **setup script** (`setup-wordpress.sh`)
* Example configuration values

---

## 📂 Repository Structure

```
wordpress-lamp-setup/
│── amazon-linux/
│   └── setup-wordpress.sh      # Shell script for Amazon Linux 2
│
│── ubuntu/
│   └── setup-wordpress.sh      # Shell script for Ubuntu 20.04 / 22.04
```

---

## 🚀 Quick Start

### On Amazon Linux 2

```bash
git clone https://github.com/<your-username>/wordpress-lamp-setup.git
cd wordpress-lamp-setup/amazon-linux
chmod +x setup-wordpress.sh
sudo ./setup-wordpress.sh
```

### On Ubuntu (20.04 / 22.04)

```bash
git clone https://github.com/<your-username>/wordpress-lamp-setup.git
cd wordpress-lamp-setup/ubuntu
chmod +x setup-wordpress.sh
sudo ./setup-wordpress.sh
```

---

## 🛠️ Notes

* Both scripts install **Apache, MySQL/MariaDB, PHP, and WordPress**.
* Database credentials are configurable inside each script:

```bash
DB_NAME="wordpress"
DB_USER="wp_user"
DB_PASS="StrongPassword@123"
```

* Change the default values before running in **production**.

---

## 🔒 Security Recommendations

* Always update system packages (`yum update` or `apt update`) before running.
* Use a **strong password** for the database user.
* Configure **firewalls/security groups** to restrict access.
* Enable **HTTPS** (e.g., Let’s Encrypt) for production deployments.

---

