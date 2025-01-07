#!/bin/bash
kubectl create namespace store-dev

cat <<EOF > sales-deploy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sales
  namespace: store-dev
spec:
  replicas: 1
  selector:
    matchLabels:
      app: sales
  template:
    metadata:
      labels:
        app: sales
    spec:
      containers:
      - name: sales
        image: nginx:latest
        ports:
        - containerPort: 80
        livenessProbe:
          httpGet:
            path: /healthz
            port: 80
          initialDelaySeconds: 5
          periodSeconds: 5
EOF

kubectl apply -f sales-deploy.yaml