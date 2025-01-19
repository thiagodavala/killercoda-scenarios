#!/bin/bash
kubectl get pod -l app=rbac-initcontainer | grep -v Running && exit 1 || exit 0