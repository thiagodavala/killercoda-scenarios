#!/bin/bash

# init scenario
rm $0
bash /ks/k8s.sh
mkdir -p /opt/ks
cat <<EOT > /root/.vimrc
set expandtab
set tabstop=2
set shiftwidth=2
EOT

# scenario specific
kubectl -f /ks/init.yaml create
clusterIP=$(kubectl get svc ingress-nginx-controller -n ingress-nginx -o jsonpath='{.spec.clusterIP}')
echo $clusterIP world.universe.mine >> /etc/hosts
kubectl -n ingress-nginx wait --for=condition=available --timeout=600s deployment/ingress-nginx-controller

# mark init finished
touch /ks/.initfinished