#!/bin/bash
kubectl create namespace store-dev

cat <<EOF > configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-config
  namespace: xpto
data:
  nginx.conf: |
    server {
        listen 80;
        
        location / {
            default_type application/json;
            return 200 '{"message":"Hello, world!"}';
        }

        location /health {
            default_type application/json;
            return 500 '{"status":"error"}';
        }
    }
EOF

cat <<EOF > deploy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: xpto
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:latest
          ports:
            - containerPort: 80
          volumeMounts:
            - name: nginx-config-volume
              mountPath: /etc/nginx/conf.d/default.conf
              subPath: nginx.conf
          livenessProbe:
            httpGet:
              path: /health
              port: 80
            initialDelaySeconds: 5
            periodSeconds: 10
      volumes:
        - name: nginx-config-volume
          configMap:
            name: nginx-config

EOF

kubectl apply -f configmap.yaml
kubectl apply -f deploy.yaml