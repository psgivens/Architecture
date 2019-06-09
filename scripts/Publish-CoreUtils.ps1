#!/usr/bin/pwsh

Write-Host "Build docker_utils image"
docker build `
    -t localhost:32000/docker_utils `
    -f "$buildpath/tools/utils.Dockerfile" `
    "$buildpath/tools"

docker push localhost:32000/docker_utils



