#!/bin/bash
sleep 10s
kubectl get pods -l app=nginx -o jsonpath='{.items[0].status.containerStatuses[0].restartCount}' -n xpto | grep -q '^[1-9]' && exit 1 || exit 0
