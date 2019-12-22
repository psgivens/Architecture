#!/usr/bin/pwsh

$buildpath = "$env:BESPIN_REPOS/Architecture"

$image = "dotnet-stage"
$image_remote = "localhost:32000/dotnet-stage"

Write-Host "Build dotnet stage image"
docker build `
    -t dotnet-stage `
    -t $image `
    -t $image_remote `
    -f "$buildpath/tools/dotnet.stage.Dockerfile" `
    "$buildpath/tools"


docker push $image_remote




