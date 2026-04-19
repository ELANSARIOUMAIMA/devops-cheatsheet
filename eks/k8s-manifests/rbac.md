# ============================================================
# RBAC (Role-Based Access Control) Configuration
# ============================================================
# RBAC is a method of regulating access to computer or network
# resources based on the roles of individual users within an
# organization. In Kubernetes, RBAC uses the
# rbac.authorization.k8s.io API group to drive authorization
# decisions, allowing admins to dynamically configure policies.
#
# Key components:
#   - ServiceAccount : Identity for processes running in a Pod
#   - Role           : Defines permissions within a namespace
#   - RoleBinding    : Grants a Role to a user/serviceaccount
#   - ClusterRole    : Defines permissions cluster-wide
#   - ClusterRoleBinding : Grants a ClusterRole cluster-wide
#
# This configuration grants the jenkins ServiceAccount all
# necessary permissions to manage workloads in the webapps
# namespace, including dynamic provisioning with StorageClasses
# and PersistentVolumes.
# ============================================================

# 1. ServiceAccount
apiVersion: v1
kind: ServiceAccount
metadata:
  name: jenkins
  namespace: webapps

---

# 2. Role (namespace-scoped permissions)
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: jenkins-role
  namespace: webapps
rules:
  # Permissions for core API resources
  - apiGroups: [""]
    resources:
      - secrets
      - configmaps
      - persistentvolumeclaims
      - services
      - pods
    verbs: ["get", "list", "watch", "create", "update", "delete","patch"]

  # Permissions for apps API group
   - apiGroups: ["apps"]
    resources:
      - deployments
      - replicasets
      - statefulsets
    verbs: ["get", "list", "watch", "create", "update", "delete","patch"]

  # Permissions for networking API group
  - apiGroups: ["networking.k8s.io"]
    resources:
      - ingresses
    verbs: ["get", "list", "watch", "create", "update", "delete","patch"]

  # Permissions for autoscaling API group
  - apiGroups: ["autoscaling"]
    resources:
      - horizontalpodautoscalers
    verbs: ["get", "list", "watch", "create", "update", "delete","patch"]

---

# 3. RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: jenkins-rolebinding
  namespace: webapps
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: jenkins-role
subjects:
  - kind: ServiceAccount
    name: jenkins
    namespace: webapps

---

# 4. ClusterRole (cluster-wide permissions)
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: jenkins-cluster-role
rules:
  # Permissions for persistentvolumes
  - apiGroups: [""]
    resources:
      - persistentvolumes
    verbs: ["get", "list", "watch", "create", "update", "delete"]
  # Permissions for storageclasses
  - apiGroups: ["storage.k8s.io"]
    resources:
      - storageclasses
    verbs: ["get", "list", "watch", "create", "update", "delete"]
  # Permissions for ClusterIssuer
  - apiGroups: ["cert-manager.io"]
    resources:
      - clusterissuers
    verbs: ["get", "list", "watch", "create", "update", "delete"]

---

# 5. ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: jenkins-cluster-rolebinding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: jenkins-cluster-role
subjects:
  - kind: ServiceAccount
    name: jenkins
    namespace: webapps

---

# ============================================================
# Explanation of Permissions
# ============================================================
# ServiceAccount:
#   - The jenkins ServiceAccount is created in the webapps namespace.
#
# Role:
#   - Grants access to namespace-specific resources:
#     - Secrets, ConfigMaps, PersistentVolumeClaims, Services, Pods
#     - Deployments, ReplicaSets, StatefulSets (apps API group)
#     - Ingresses (networking.k8s.io API group)
#     - HorizontalPodAutoscalers (autoscaling API group)
#
# RoleBinding:
#   - Binds the jenkins Role to the ServiceAccount in the webapps namespace.
#
# ClusterRole:
#   - Grants access to cluster-wide resources:
#     - PersistentVolumes (required for dynamic provisioning)
#     - StorageClasses (required to create and manage storage classes)
#     - ClusterIssuers (cert-manager)
#
# ClusterRoleBinding:
#   - Binds the jenkins ClusterRole to the ServiceAccount cluster-wide.
#
# ============================================================
# How to Apply
# ============================================================
# Apply everything in one command:
#   kubectl apply -f jenkins-rbac.yaml
#
# Or apply separately in this order:
#   kubectl apply -f serviceaccount.yaml
#   kubectl apply -f role.yaml
#   kubectl apply -f rolebinding.yaml
#   kubectl apply -f clusterrole.yaml
#   kubectl apply -f clusterrolebinding.yaml
#
# ============================================================
# Verify Permissions
# ============================================================
#   kubectl auth can-i create secrets \
#     --as=system:serviceaccount:webapps:jenkins -n webapps
#
#   kubectl auth can-i create storageclasses \
#     --as=system:serviceaccount:webapps:jenkins
#
#   kubectl auth can-i create persistentvolumes \
#     --as=system:serviceaccount:webapps:jenkins
#
# ============================================================
# Generate Token for Jenkins ServiceAccount
# ============================================================
#   kubectl create token jenkins -n webapps
