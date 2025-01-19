#!/bin/bash
kubectl get pod -l app=rbac-initcontainer | grep Running | grep -q 'true' && exit 0 || exit 1