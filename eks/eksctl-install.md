# ⚙️ eksctl Installation
```bash

curl -sLO "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz"

tar -xzf eksctl_$(uname -s)_amd64.tar.gz

sudo mv eksctl /usr/local/bin

eksctl version
```

## Associate OIDC Provider
Without OIDC:
Kubernetes pods → cannot talk to AWS services ❌

With OIDC:
Kubernetes pods → can talk to AWS services ✅
                  (S3, ECR, DynamoDB, etc.)

# ⚠️ Modify: cluster name and region
```bash
eksctl utils associate-iam-oidc-provider \
--cluster my-eks-cluster \
--region us-east-1 \
--approve
```

## Create IAM Service Account => Allows pods to interact with AWS services using IAM permissions securely
# ⚠️ Modify: cluster name and region
```bash
eksctl create iamserviceaccount \
--name my-service-account \
--namespace kube-system \
--cluster my-eks-cluster \
--region us-east-1 \
--attach-policy-arn arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy \
--approve \
--override-existing-serviceaccounts
```

## Install EBS CSI Driver => Allows Kubernetes pods to use AWS EBS (Elastic Block Storage) so Your pods can store data
```bash
kubectl apply -k \
"github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/ecr/?ref=release-1.11"
```

## Install Ingress NGINX => Traffic manager for your cluster  Routes external traffic to the right service/pod
```bash
kubectl apply -f \
https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
```

## Install Cert Manager => Automatically manages SSL/TLS certificates so Your app gets HTTPS automatically! 🔒
```bash
kubectl apply -f \
https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.yaml
```
