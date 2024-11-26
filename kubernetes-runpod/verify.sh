#!/bin/bash
kubectl get pod teste-pod -o json | jq .spec.containers[].image | grep nginx