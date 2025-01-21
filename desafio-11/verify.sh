#!/bin/bash
kubectl get deployment demo-deployment -o jsonpath="{.spec.template.spec.containers[0].image}" | grep nginx:1.26.2-perl