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
        - "apk add --no-cache stress-ng && stress-ng --cpu 4 --vm 4 --vm-bytes 256M --timeout 600s"
        resources:
          limits:
            memory: "10Mi"
            cpu: "100m"
          requests:
            memory: "10Mi"
            cpu: "100m"
EOF

kubectl apply -f deploy.yaml