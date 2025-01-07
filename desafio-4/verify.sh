#!/bin/bash
kubectl get pods -l app=sales -o jsonpath='{.items[0].status.containerStatuses[0].restartCount}' -n store-dev | grep -q '^[1-9]' && exit 1 || exit 0
