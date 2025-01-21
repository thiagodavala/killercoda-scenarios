#!/bin/bash

kubectl create namespace backend
kubectl create namespace frontend

cat <<EOF > backend.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api-deployment
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: api
  template:
    metadata:
      labels:
        app: api
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
        volumeMounts:
        - name: json-volume
          mountPath: /usr/share/nginx/html
      volumes:
      - name: json-volume
        configMap:
          name: api-configmap
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: api-configmap
  namespace: default
data:
  index.html: |
    {
      "message": "OK",
      "status": 200
    }
  default.conf: |
    server {
        listen 80;
        server_name localhost;

        location / {
            root /usr/share/nginx/html;
            index index.html;
            default_type application/json;
        }
    }
---
apiVersion: v1
kind: Service
metadata:
  name: api-service
  namespace: backend
spec:
  selector:
    app: api
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
  type: ClusterIP
EOF

cat <<EOF > frontend.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-deployment
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      volumes:
      - name: shared-volume
        emptyDir: {}
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
        volumeMounts:
        - name: shared-volume
          mountPath: /usr/share/nginx/html
      - name: busybox
        image: busybox:latest
        command:
        - sh
        - -c
        - |
          while true; do
            if curl -s http://api-service.backend.svc.cluster.local | grep -q "OK"; then
              echo "<html><body><h1>Connection Successful</h1><p>Data from backend:</p><pre>$(curl -s http://nginx-json-service.other-namespace.svc.cluster.local)</pre></body></html>" > /shared/index.html
            else
              echo "<html><body><h1>Connection Failed</h1></body></html>" > /shared/index.html
            fi
            sleep 10;
          done
        volumeMounts:
        - name: shared-volume
          mountPath: /shared
---
apiVersion: v1
kind: Service
metadata:
  name: web-service
  namespace: frontend
spec:
  selector:
    app: web
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
  type: LoadBalancer
EOF

kubectl apply -f backend.yaml
kubectl apply -f frontend.yaml