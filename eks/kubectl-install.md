# ⚙️ kubectl Installation

curl -LO "https://dl.k8s.io/release/$(curl -L -s \
https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

curl -LO "https://dl.k8s.io/release/$(curl -L -s \
https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client

## Connect to EKS Cluster
# ⚠️ Modify: region and cluster name
aws eks --region us-east-1 update-kubeconfig --name your-cluster-name

## Verify Connection
kubectl get nodes
