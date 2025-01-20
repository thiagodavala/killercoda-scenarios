#!/bin/bash

cat <<EOF > deploy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: demo
  labels:
    app: demo
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
        image: python:3.11-slim
        command:
        - python
        - -c
        - |
          import time
          memory = [0] * (50 * 1024 * 1024 // 4)  # Aloca 50Mi de memória (inteiros de 4 bytes)
          print("Allocated fixed memory, sleeping indefinitely.")
          while True:
              time.sleep(10)  # Aguarda sem aumentar mais o uso de memória
        resources:
          limits:
            memory: "40Mi"
          requests:
            memory: "30Mi"

EOF

kubectl apply -f deploy.yaml