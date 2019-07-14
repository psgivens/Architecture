#!/usr/bin/pwsh

# 1. Create the configmap
#Initialize-MicroservicePart.ps1 -ServiceName router -Part configmap

$ServiceName = 'router'

# 2. Start the container
kubectl create -f "$kubeconfig/$ServiceName-replicaset.yaml"

# 3. Start the nodeport
kubectl create -f "$kubeconfig/$ServiceName-service-public.yaml"
