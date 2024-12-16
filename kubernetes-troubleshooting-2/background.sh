#!/bin/bash
kubectl create namespace capivara

cat <<EOF > deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app2
  namespace: capivara
  labels:
    app: app2
spec:
  replicas: 1
  selector:
    matchLabels:
      app: app2
  template:
    metadata:
      labels:
        app: app2
    spec:
      containers:
      - name: app2
        image: thiagoogeremias86/olamundo:1
        env:
        resources:
          limits:
            memory: "64Mi"
            cpu: "250m"
EOF

kubectl apply -f deployment.yaml