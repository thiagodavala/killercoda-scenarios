#!/bin/bash
kubectl create namespace capivara

cat <<EOF > job.yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: paco
  namespace: capivara
spec:
  template:
    spec:
      containers:
      - name: paco
        image: thiagoogeremias86/olamundo:1
      restartPolicy: onFailure
EOF

kubectl apply -f job.yaml