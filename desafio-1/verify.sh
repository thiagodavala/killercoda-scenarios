#!/bin/bash
kubectl get pod teste-pod -o jsonpath='{.status.phase} {.spec.containers[0].image}' | grep -i "Running nginx"