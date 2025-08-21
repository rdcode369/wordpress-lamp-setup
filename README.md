
# 📌 README.md

# 📂 Repository Structure

```
wordpress-lamp-setup/
│── amazon-linux/
│   ├── setup-wordpress.sh     # Shell script for Amazon Linux 2
│
│── ubuntu/
│__ ├── setup-wordpress.sh     # Shell script for Ubuntu 20.04 / 22.04
```

---

````markdown
# WordPress LAMP Setup (Amazon Linux & Ubuntu)

This repository provides automated scripts to install and configure a LAMP stack (Linux, Apache, MySQL, PHP) with WordPress on:

- ✅ Amazon Linux 2  
- ✅ Ubuntu 20.04 / 22.04  

Each environment has its own folder with:
- A **setup script** (`setup-wordpress.sh`)
---

## 🚀 Quick Start

### Amazon Linux 2
```bash
git clone https://github.com/<your-username>/wordpress-lamp-setup.git
cd wordpress-lamp-setup/amazon-linux
chmod +x setup-wordpress.sh
sudo ./setup-wordpress.sh
````

### Ubuntu (20.04 / 22.04)

```bash
git clone https://github.com/<your-username>/wordpress-lamp-setup.git
cd wordpress-lamp-setup/ubuntu
chmod +x setup-wordpress.sh
sudo ./setup-wordpress.sh
```

---



## 🛠️ Notes

* Both scripts install **Apache, MySQL, PHP, and WordPress**.
* Database credentials are configurable inside the scripts:

  ```bash
  DB_NAME="wordpress"
  DB_USER="wp_user"
  DB_PASS="StrongPassword@123"
  ```
* Change the default values before running in **production**.

---

## 🔒 Security

* Always update system packages (`yum update` / `apt update`) before running.
* Change **DB password** and set up a **firewall/security group**.
* Use **HTTPS** (e.g., Let’s Encrypt) for production.

---


