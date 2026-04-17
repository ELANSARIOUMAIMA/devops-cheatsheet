# 📦 Nexus Setup

## Install & Run Nexus (Docker)
sudo apt update
sudo apt install docker.io -y
sudo usermod -aG docker $USER
newgrp docker

# ⚠️ Nexus runs on port 8081
docker run -d -p 8081:8081 sonatype/nexus3
docker ps

## Get Initial Admin Password
docker exec -it <container-name-or-id> bash
cat /nexus-data/admin.password
