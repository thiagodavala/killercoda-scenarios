#!/bin/bash

cat <<EOF > deploys.yaml
# PersistentVolume.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: example-pv
  labels:
    storage: fast
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: manual
  hostPath:
    path: /mnt/data
---
# PersistentVolumeClaim.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: example-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
  selector:
    matchLabels:
      storage: slow
  storageClassName: manual
---
# Deployment.yaml (opcional, para criar um pod que tenta usar o PVC)
apiVersion: apps/v1
kind: Deployment
metadata:
  name: pvc-test-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: pvc-test
  template:
    metadata:
      labels:
        app: pvc-test
    spec:
      containers:
        - name: pvc-test-container
          image: nginx
          volumeMounts:
            - name: test-volume
              mountPath: /usr/share/nginx/html
      volumes:
        - name: test-volume
          persistentVolumeClaim:
            claimName: example-pvc
EOF

kubectl apply -f deploys.yaml