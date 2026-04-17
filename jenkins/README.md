# 🔧 Jenkins Setup

## Step 1 - Install Java : you can tap java and it will give you the command that you should to run 
```bash
sudo apt update
```
```bash
sudo apt install openjdk-17-jre-headless -y
```
```bash
java -version
```

## Step 2 - Install Jenkins : you can tap in google install jenkins and choose linux ,click on ubuntu machine and git the command
```bash
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update
sudo apt install jenkins
```

# Jenkins runs on port 8080 by default
# Get initial admin password:
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

## Step 3 - Install Plugins
# Go to: Manage Jenkins > Plugins > Available
# Install these plugins:
- Pipeline Stage View
- SonarQube Scanner
- Config File Provider  => why that because when jenkins want to push the artificats to nexus it need to know nexus url +Provide credentials

- Maven Integration
- Pipeline Maven Integration
- Docker Pipeline
- Kubernetes
- Kubernetes CLI
- Kubernetes Client API

## Step 4 - Configure Tools
# Go to: Manage Jenkins > Tools
# Add Maven → name: maven3 → latest version
# Add SonarQube Scanner → latest version

## Step 5 - Add Jenkins user to Docker group
sudo usermod -aG docker jenkins
# Then restart Jenkins:
# http://<jenkins-url>:8080/restart
