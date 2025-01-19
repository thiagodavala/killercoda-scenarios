#!/bin/bash
kubectl get pod -l app=rbac-initcontainer -o=jsonpath='{.status.initContainerStatuses[0].state.running}' | grep -q 'true' && exit 0 || exit 1