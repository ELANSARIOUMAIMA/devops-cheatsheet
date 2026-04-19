# Add the Helm repo
helm repo add prometheus-community \
  https://prometheus-community.github.io/helm-charts
helm repo update

# Install the stack
helm upgrade --install monitoring prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --create-namespace \
  -f prometheus-values.yaml

# Verify the pods are running
kubectl get pods -n monitoring

# Get the LoadBalancer URLs
kubectl get svc -n monitoring
