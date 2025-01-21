#!/bin/bash

kubectl create namespace backend
kubectl create namespace frontend

cat <<EOF > backend.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api
  namespace: backend
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
      - name: json-server
        image: typicode/json-server:latest
        args: ["--watch", "/data/db.json"]
        ports:
        - containerPort: 80
        env:
        - name: NODE_ENV
          value: "production"
---
apiVersion: v1
kind: Service
metadata:
  name: api-service
  namespace: backend
spec:
  selector:
    app: backend
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
  namespace: frontend
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
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
        volumeMounts:
        - name: html-volume
          mountPath: /usr/share/nginx/html
      volumes:
      - name: html-volume
        configMap:
          name: web-configmap
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: web-configmap
  namespace: frontend
data:
  index.html: |
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Frontend</title>
      <script>
        async function fetchBackendData() {
          try {
            const response = await fetch("http://backend-service.backend.svc.cluster.local/posts");
            const data = await response.json();
            const container = document.getElementById("data");
            container.innerHTML = JSON.stringify(data, null, 2);
          } catch (error) {
            console.error("Error fetching data:", error);
            document.getElementById("data").innerText = "Error fetching data from backend.";
          }
        }
        window.onload = fetchBackendData;
      </script>
    </head>
    <body>
      <h1>Frontend Consuming Backend</h1>
      <pre id="data" style="background: #f4f4f4; padding: 10px; border-radius: 5px;"></pre>
    </body>
    </html>
EOF

kubectl apply -f backend.yaml
kubectl apply -f frontend.yaml