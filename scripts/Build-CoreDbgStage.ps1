#!/usr/bin/pwsh

Write-Host "Build dotnet stage image"
docker build `
    -t dotnet-stage `
    -f "$buildpath/tools/dotnet.stage.Dockerfile" `
    "$buildpath/tools"





