#!/usr/bin/pwsh

$buildpath = "$env:BESPIN_REPOS/Architecture"

Write-Host "Build docker_utils image"
docker build `
    -t localhost:32000/docker_utils `
    -f "$buildpath/tools/utils.Dockerfile" `
    "$buildpath/tools"

docker push localhost:32000/docker_utils



