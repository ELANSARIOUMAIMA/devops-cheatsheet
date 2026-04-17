# 🔒 Trivy Installation

## Install Trivy
```bash
sudo apt-get install -y wget apt-transport-https gnupg lsb-release

wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -

echo deb https://aquasecurity.github.io/trivy-repo/deb \
$(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list

sudo apt-get update
sudo apt-get install -y trivy
```


## Basic Usage
# Scan Docker image
trivy image --severity HIGH,CRITICAL <image-name>:<tag>

# Scan filesystem
trivy fs .
