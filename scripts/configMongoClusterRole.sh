#!/usr/bin/env bash

SANAME="$1"
NAMESPACE="$2"

CHARTS_DIR=$(cd $(dirname $0)/../charts; pwd -P)

if [[ "$3" == "destroy" ]]; then
    echo "removing cluster role and binding..."
    kubectl delete ClusterRoleBinding ${SANAME}
    kubectl delete ClusterRole ${SANAME}
    ##kubectl delete -f "${CHARTS_DIR}/cluster_role.yaml"
else 
##kubectl create -f "${CHARTS_DIR}/cluster_role.yaml"
#build cluster role
cat > "${CHARTS_DIR}/mongocluster_role.yaml" << EOL
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  creationTimestamp: null
  name: ${SANAME}
rules:
- apiGroups:
  - ""
  resources:
  - pods
  - services
  - serviceaccounts
  - services/finalizers
  - endpoints
  - persistentvolumeclaims
  - events
  - configmaps
  - secrets
  verbs:
  - create
  - delete
  - get
  - list
  - patch
  - update
  - watch
- apiGroups:
  - apps
  resources:
  - deployments
  - daemonsets
  - replicasets
  - statefulsets
  verbs:
  - create
  - delete
  - get
  - list
  - patch
  - update
  - watch
- apiGroups:
  - monitoring.coreos.com
  resources:
  - servicemonitors
  verbs:
  - get
  - create
- apiGroups:
  - apps
  resourceNames:
  - mongodb-kubernetes-operator
  resources:
  - deployments/finalizers
  verbs:
  - update
- apiGroups:
  - rbac.authorization.k8s.io
  resources:
  - clusterrolebindings
  - clusterroles
  - rolebindings
  - roles
  verbs:
  - '*'
- apiGroups:
  - ""
  resources:
  - namespaces
  verbs:
  - get    
- apiGroups:
  - ""
  resources:
  - pods
  verbs:
  - get
- apiGroups:
  - apps
  resources:
  - replicasets
  - deployments
  verbs:
  - get
- apiGroups:
  - mongodbcommunity.mongodb.com
  resources:
  - mongodbcommunity
  - mongodbcommunity/status
  - mongodbcommunity/spec
  - mongodbcommunity/finalizers
  verbs:
  - create
  - delete
  - get
  - list
  - patch
  - update
  - watch
- apiGroups:
    - security.openshift.io
  resourceNames:
    - ${NAMESPACE}-${SANAME}-anyuid
  resources:
    - securitycontextconstraints
  verbs:
    - use  
EOL
#build cluster role binding
cat > "${CHARTS_DIR}/mongocluster_role_binding.yaml" << EOL
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: ${SANAME}
subjects:
- kind: ServiceAccount
  name: ${SANAME}
  namespace: ${NAMESPACE}
roleRef:
  kind: ClusterRole
  name: ${SANAME}
  apiGroup: rbac.authorization.k8s.io
EOL
    kubectl create -f "${CHARTS_DIR}/mongocluster_role.yaml"
    kubectl create -f "${CHARTS_DIR}/mongocluster_role_binding.yaml"
fi
