#!/bin/bash
SVC_IP=$(kubectl get svc faulty-service -o jsonpath='{.spec.clusterIP}')
curl $SVC_IP  | grep -o '<title>.*</title>'