#!/bin/bash
kubectl get pods -l app=rbac-initcontainer --no-headers | awk '{if ($2 != "Running") {print "Pod " $1 " não está em Running. Status: " $2; exit 1}}' || exit 0