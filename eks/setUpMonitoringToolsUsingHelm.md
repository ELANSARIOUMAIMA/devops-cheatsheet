# ============================================================
# Monitoring Stack - Helm Values Configuration
# Tools: Prometheus, Grafana, NodeExporter, KubeStateMetrics
# Chart: kube-prometheus-stack
# ============================================================

---
alertmanager:
  enabled: false

prometheus:
  prometheusSpec:
    service:
      type: LoadBalancer
    storageSpec:
      volumeClaimTemplate:
        spec:
          storageClassName: ebs-sc
          accessModes:
            - ReadWriteOnce
          resources:
            requests:
              storage: 5Gi

grafana:
  enabled: true
  service:
    type: LoadBalancer
  adminUser: admin
  adminPassword: admin123

nodeExporter:
  service:
    type: LoadBalancer

kubeStateMetrics:
  enabled: true
  service:
    type: LoadBalancer

additionalScrapeConfigs:
  - job_name: node-exporter
    static_configs:
      - targets:
          - node-exporter:9100
  - job_name: kube-state-metrics
    static_configs:
      - targets:
          - kube-state-metrics:8080

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
