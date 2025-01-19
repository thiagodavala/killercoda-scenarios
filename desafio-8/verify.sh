#!/bin/bash
kubectl get pods -l app=pvc-test 2>/dev/null | grep -q "Running" && exit 0 || exit 1