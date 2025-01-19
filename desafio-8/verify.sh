#!/bin/bash
k get pods -l app=pvc-test | grep Running