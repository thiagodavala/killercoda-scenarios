
Crie um pod com o nome teste-pod com a imagem: nginx no namespace default

```
apiVersion: v1
kind: Pod
metadata:
  name: teste-pod
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80

```{{exec}}
