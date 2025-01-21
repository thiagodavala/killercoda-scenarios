#!/bin/bash
kubectl get deployment nginx-deployment -o jsonpath="{.spec.template.spec.containers[0].image}" | grep nginx:1.26.2-perl