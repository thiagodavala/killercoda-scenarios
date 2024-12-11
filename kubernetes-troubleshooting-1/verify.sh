#!/bin/bash
kubectl get pods -n capivara -o jsonpath='{.status.phase} {.spec.containers[0].image}' | grep -i "Running nginx"