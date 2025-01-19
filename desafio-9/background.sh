#!/bin/bash

cat <<EOF > deploys.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: limited-sa
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default
  name: limited-role
rules:
  - apiGroups: [""]
    resources: ["pods"]
    verbs: ["delete"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: limited-rolebinding
  namespace: default
subjects:
  - kind: ServiceAccount
    name: limited-sa
    namespace: default
roleRef:
  kind: Role
  name: limited-role
  apiGroup: rbac.authorization.k8s.io
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: rbac-initcontainer-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: rbac-initcontainer
  template:
    metadata:
      labels:
        app: rbac-initcontainer
    spec:
      serviceAccountName: limited-sa
      initContainers:
        - name: check-permission
          image: busybox
          command: ["sh", "-c", "kubectl get pods --namespace=default"]
      containers:
        - name: main-container
          image: nginx
          ports:
            - containerPort: 80
EOF

kubectl apply -f deploys.yaml