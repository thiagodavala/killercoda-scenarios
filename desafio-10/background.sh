#!/bin/bash

cat <<EOF > deploy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: demo
spec:
  replicas: 2
  selector:
    matchLabels:
      app: stress-app
  template:
    metadata:
      labels:
        app: stress-app
    spec:
      containers:
      - name: stress-ng
        image: alpine:3.14
        command:
        - "sh"
        - "-c"
        - "apk add --no-cache stress-ng && stress-ng --cpu 2 --vm 2 --vm-bytes 128M --timeout 600s"
        resources:
          limits:
            memory: "64Mi"
            cpu: "250m"
          requests:
            memory: "64Mi"
            cpu: "250m"
EOF

kubectl apply -f deploy.yaml