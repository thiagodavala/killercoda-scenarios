#!/bin/bash
kubectl get pods  -l app=rbac-initcontainer | grep Running