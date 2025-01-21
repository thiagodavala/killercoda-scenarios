#!/bin/bash

cat <<EOF > deploy-v1.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: demo-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: demo
  template:
    metadata:
      labels:
        app: demo
    spec:
      containers:
      - name: demo
        image: nginx:1.26.2-perl
EOF

cat <<EOF > deploy-v2.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: demo-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: demo
  template:
    metadata:
      labels:
        app: demo
    spec:
      containers:
      - name: demo
        image: nginx:1.27.3-perl
EOF

kubectl apply -f deploy-v1.yaml
sleep 10s
kubectl apply -f deploy-v2.yaml