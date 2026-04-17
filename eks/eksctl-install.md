# ⚙️ eksctl Installation

curl -sLO "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz"
tar -xzf eksctl_$(uname -s)_amd64.tar.gz
sudo mv eksctl /usr/local/bin
eksctl version

## Associate OIDC Provider
# ⚠️ Modify: cluster name and region
eksctl utils associate-iam-oidc-provider \
--cluster my-eks-cluster \
--region us-east-1 \
--approve

## Create IAM Service Account
# ⚠️ Modify: cluster name and region
eksctl create iamserviceaccount \
--name my-service-account \
--namespace kube-system \
--cluster my-eks-cluster \
--region us-east-1 \
--attach-policy-arn arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy \
--approve \
--override-existing-serviceaccounts

## Install EBS CSI Driver
kubectl apply -k \
"github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/ecr/?ref=release-1.11"

## Install Ingress NGINX
kubectl apply -f \
https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml

## Install Cert Manager
kubectl apply -f \
https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.yaml
