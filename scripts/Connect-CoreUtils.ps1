#!/usr/bin/pwsh

Write-Host "Connecting with docker_utils"
kubectl run `
    -it `
    --rm `
    --restart=Never `
    docker-utils `
    -- /bin/bash `


    