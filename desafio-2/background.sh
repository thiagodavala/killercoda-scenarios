#!/bin/bash

kubectl create namespace capivara

cat <<EOF > deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app1-deployment
  namespace: capivara
  labels:
    app: app1
spec:
  replicas: 3
  selector:
    matchLabels:
      app: app1
  template:
    metadata:
      labels:
        app: app1
    spec:
      containers:
      - name: app1
        image: nginxfake:latest
        ports:
        - containerPort: 80
EOF

kubectl apply -f deployment.yaml