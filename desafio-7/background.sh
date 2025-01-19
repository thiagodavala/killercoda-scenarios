#!/bin/bash
kubectl create namespace xpto

cat <<EOF > deploy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: faulty-service-app
  labels:
    app: faulty-service
spec:
  replicas: 2
  selector:
    matchLabels:
      app: faulty-service
  template:
    metadata:
      labels:
        app: faulty-service
    spec:
      containers:
      - name: web-server
        image: nginx:1.21
        ports:
        - containerPort: 8080
EOF

cat <<EOF > service.yaml
apiVersion: v1
kind: Service
metadata:
  name: faulty-service
spec:
  type: NodePort
  selector:
    app: faulty-service
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
    nodePort: 30001
EOF

kubectl apply -f deploy.yaml
kubectl apply -f service.yaml