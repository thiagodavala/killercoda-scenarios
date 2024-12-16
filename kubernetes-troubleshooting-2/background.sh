#!/bin/bash

kubectl create namespace capivara

cat <<EOF > deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app2
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
        image: busybox
        command: ["/bin/sh", "-c"]
        args:
          - echo "The REQUIRED_ENV is: \$REQUIRED_ENV";
            if [ -z "\$REQUIRED_ENV" ]; then
              echo "Error: REQUIRED_ENV is not set!";
              exit 1;
            fi;
            echo "Variable is set!";
        env: # Nenhuma variável de ambiente é configurada aqui.
        resources:
          limits:
            memory: "64Mi"
            cpu: "250m"
        restartPolicy: Always
EOF

kubectl apply -f deployment.yaml