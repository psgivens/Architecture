#!/usr/bin/pwsh

Write-Host "Connecting with docker_utils"
kubectl run `
    -it docker-utils1 `
    --image="localhost:32000/docker_utils" `
    --rm `
    --restart=Never -- /bin/bash


    