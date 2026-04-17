# 🔍 SonarQube Setup

## Install & Run SonarQube (Docker)
```bash
sudo apt update
```
```bash
sudo apt install docker.io -y
```
```bash
sudo usermod -aG docker ubuntu
```
```bash
newgrp docker
```

# ⚠️ SonarQube runs on port 9000
docker run -d -p 9000:9000 sonarqube:lts-community

# Default credentials:
# Username: admin
# Password: admin

## Webhook Configuration
# Go to: SonarQube > Administration > Webhooks > Create
# ⚠️ Modify Jenkins URL:
# Name: Jenkins
# URL: http://<jenkins-ip>:8080/sonarqube-webhook/
