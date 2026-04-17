# 📦 Nexus Setup

## Install & Run Nexus (Docker)
```bash
sudo apt update
```
```bash
sudo apt install docker.io -y
```
```bash
sudo usermod -aG docker $USER #that means the current user
```
```bash
newgrp docker
```


# ⚠️ Nexus runs on port 8081
docker run -d -p 8081:8081 sonatype/nexus3
docker ps

## Get Initial Admin Password
```bash
docker exec -it <container-name-or-id>
```
```bash
ls
```
```bash
cd nexus3/
```
```bash
ls
```
```bash
cat admin.password
```
#don't copy bash
